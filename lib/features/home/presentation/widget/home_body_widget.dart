import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packages/widget/Bottom_sheet/custom_bottom_sheet.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:vinemas_v1/core/common/enum/configuration.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/common/extension/configuration_extension.dart';
import 'package:vinemas_v1/core/common/extension/genres_extension.dart';
import 'package:vinemas_v1/core/global/global_bloc/global_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/now_playing_bloc/now_playing_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/upcoming_bloc/upcoming_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/widget/movie_item_widget.dart';
import 'package:vinemas_v1/features/home/presentation/widget/upcoming_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class HomeBodyWidget extends StatefulWidget {
  const HomeBodyWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeBodyWidgetState createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  late ScrollController _scrollController;
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });

        final currentState = context.read<NowPlayingBloc>().state;

        if (currentState is NowPlayingLoadedState) {
          final currentMovies = currentState.nowPlaying ?? [];
          final nextPage = _currentPage + 1;

          context.read<NowPlayingBloc>().add(
                NowPlayingLoadMoreEvent(movie: currentMovies, page: nextPage),
              );
          _currentPage = nextPage;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        thickness: 4,
        radius: const Radius.circular(8),
        child: CustomScrollView(
          controller: _scrollController,
          primary: false,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 80)),
            SliverToBoxAdapter(
              child: BlocBuilder<UpcomingBloc, UpcomingState>(
                builder: (context, homeState) {
                  if (homeState is UpcomingLoadedState) {
                    switch (homeState.state) {
                      case ProcessStatus.loading:
                        return const Center(child: CircularProgressIndicator());
                      case ProcessStatus.success:
                        final upcomingPoster = homeState.upcoming;
                        return BlocBuilder<GlobalBloc, GlobalState>(
                          builder: (_, globalState) {
                            final configuration = globalState.configuration;
                            if (upcomingPoster != null &&
                                configuration != null) {
                              final listUpcomingMoviesPoster = upcomingPoster
                                  .map((e) =>
                                      "${configuration.getPosterUrl(e.posterPath, size: PosterSize.w342)}")
                                  .toList();
                              return UpcomingWidget(
                                  listMovie: upcomingPoster,
                                  listUpcommingMoviesPoster:
                                      listUpcomingMoviesPoster);
                            }
                            return const SizedBox();
                          },
                        );
                      case ProcessStatus.failure:
                        return Center(
                            child: Text("Error: ${homeState.errorMsg}"));
                      case ProcessStatus.idle:
                      default:
                        return const SizedBox();
                    }
                  }
                  return const SizedBox();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: CustomLayoutHorizontal(
                crossAxisAlignment: CrossAxisAlignment.center,
                leftWidget: Text(
                  AppLocalizations.of(context)!.keyword_now_in_cinemas,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                rightWidget: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    CustomBottomSheet.show(context, body: Container());
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SvgPicture.asset($AssetsIconsGen().iconApp.search),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 8.0, left: 12, right: 12),
              sliver: BlocBuilder<NowPlayingBloc, NowPlayingState>(
                builder: (context, homeState) {
                  if (homeState is NowPlayingLoadedState) {
                    switch (homeState.state) {
                      case ProcessStatus.loading:
                        return const SliverToBoxAdapter(
                            child: Center(child: CircularProgressIndicator()));
                      case ProcessStatus.success:
                        final nowPlaying = homeState.nowPlaying;
                        return BlocBuilder<GlobalBloc, GlobalState>(
                          builder: (context, globalState) {
                            final configuration = globalState.configuration;
                            final genres = globalState.genres;
                            if (nowPlaying != null &&
                                configuration != null &&
                                genres != null) {
                              return SliverGrid.builder(
                                itemCount: nowPlaying.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.54,
                                ),
                                itemBuilder: (context, index) {
                                  final listGenreName =
                                      genres.convertGenreIdsToNames(
                                          nowPlaying[index].genreIds);
                                  return MovieItemWidget(
                                    movie: nowPlaying[index],
                                    posterImgPath:
                                        "${configuration.getPosterUrl(nowPlaying[index].posterPath, size: PosterSize.w342)}",
                                    title: nowPlaying[index].title,
                                    genres: listGenreName.join(', '),
                                    score: nowPlaying[index].voteAverage,
                                  );
                                },
                              );
                            }
                            return const SliverToBoxAdapter(child: SizedBox());
                          },
                        );

                      case ProcessStatus.failure:
                        return SliverToBoxAdapter(
                            child: Center(
                                child: Text("Error: ${homeState.errorMsg}")));
                      case ProcessStatus.idle:
                      default:
                        return const SliverToBoxAdapter(child: SizedBox());
                    }
                  }
                  return const SliverToBoxAdapter(child: SizedBox());
                },
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: 16)),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<NowPlayingBloc>().stream.listen((state) {
      if (state is NowPlayingLoadedState) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
