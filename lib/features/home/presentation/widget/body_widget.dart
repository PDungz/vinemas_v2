import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packages/widget/Bottom_sheet/custom_bottom_sheet.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:vinemas_v1/core/common/enum/configuration.dart';
import 'package:vinemas_v1/core/common/enum/status_state.dart';
import 'package:vinemas_v1/core/common/extension/configuration_extension.dart';
import 'package:vinemas_v1/core/common/extension/genres_extension.dart';
import 'package:vinemas_v1/core/global/global_bloc/global_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/now_playing_bloc/now_playing_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/upcoming_bloc/upcoming_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/widget/movie_item_widget.dart';
import 'package:vinemas_v1/features/home/presentation/widget/upcoming_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UpcomingBloc>(
          create: (context) => UpcomingBloc()..add(UpcomingLoadEvent()),
        ),
        BlocProvider<NowPlayingBloc>(
          create: (context) => NowPlayingBloc()..add(NowPlayingLoadEvent()),
        ),
      ],
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 80,
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<UpcomingBloc, UpcomingState>(
              builder: (context, homeState) {
                if (homeState is UpcomingLoadedState) {
                  switch (homeState.state) {
                    case StatusState.loading:
                      return const Center(child: CircularProgressIndicator());
                    case StatusState.success:
                      final upcomingPoster = homeState.upcoming;
                      return BlocBuilder<GlobalBloc, GlobalState>(
                        builder: (_, globalState) {
                          final configuration = globalState.configuration;
                          if (upcomingPoster != null && configuration != null) {
                            final listUpcomingMoviesPoster = upcomingPoster
                                .map((e) =>
                                    "${configuration.getPosterUrl(e.posterPath, size: PosterSize.w342)}")
                                .toList();
                            return UpcomingWidget(
                              listUpcommingMoviesPoster:
                                  listUpcomingMoviesPoster,
                            );
                          }
                          return const SizedBox();
                        },
                      );
                    case StatusState.failure:
                      return Center(
                        child: Text("Error: ${homeState.errorMsg}"),
                      );
                    case StatusState.idle:
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
            padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
            sliver: BlocBuilder<NowPlayingBloc, NowPlayingState>(
              builder: (context, homeState) {
                if (homeState is NowPlayingLoadedState) {
                  switch (homeState.state) {
                    case StatusState.loading:
                      return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );

                    case StatusState.success:
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
                                  childAspectRatio: 0.56,
                                ),
                                itemBuilder: (context, index) {
                                  final listGenreName =
                                      genres.convertGenreIdsToNames(
                                          nowPlaying[index].genreIds);
                                  return MovieItemWidget(
                                    posterImgPath:
                                        "${configuration.getPosterUrl(nowPlaying[index].posterPath, size: PosterSize.w342)}",
                                    title: nowPlaying[index].title,
                                    genres: listGenreName.join(
                                        ', '), // Replace with dynamic genre if available
                                    score: nowPlaying[index].voteAverage,
                                  );
                                });
                          }
                          return const SliverToBoxAdapter(
                            child: SizedBox(),
                          );
                        },
                      );

                    case StatusState.failure:
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text("Error: ${homeState.errorMsg}"),
                        ),
                      );

                    case StatusState.idle:
                    default:
                      return const SliverToBoxAdapter(
                        child: SizedBox(),
                      );
                  }
                }
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              },
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 16)),
        ],
      ),
    );
  }
}
