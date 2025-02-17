import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinemas_v1/core/common/enum/configuration.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/common/extension/configuration_extension.dart';
import 'package:vinemas_v1/core/common/extension/genres_extension.dart';
import 'package:vinemas_v1/core/global/global_bloc/global_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/now_playing_bloc/now_playing_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/widget/movie_item_widget.dart';
import 'package:vinemas_v1/features/home/presentation/widget/now_playing_loading_widget.dart';

class NowPlayingWidget extends StatelessWidget {
  const NowPlayingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingBloc, NowPlayingState>(
      builder: (context, homeState) {
        if (homeState is NowPlayingLoadedState) {
          switch (homeState.state) {
            case ProcessStatus.loading:
              return NowPlayingLoadingWidget();
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
                        final listGenreName = genres
                            .convertGenreIdsToNames(nowPlaying[index].genreIds);
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
                  child: Center(child: Text("Error: ${homeState.errorMsg}")));
            case ProcessStatus.idle:
            default:
              return const SliverToBoxAdapter(child: SizedBox());
          }
        }
        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}
