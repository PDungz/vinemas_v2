import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packages/widget/Layout/custom_layout_label_value.dart';
import 'package:packages/widget/Shimmer/custom_shimmer.dart';
import 'package:packages/widget/Text/custom_text.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/bloc/about_bloc/about_bloc.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/about_movie_rating.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutBloc>(
      create: (context) =>
          AboutBloc()..add(MovieDetailEvent(movieId: movie.id)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 108),
            BlocBuilder<AboutBloc, AboutState>(
              builder: (context, aboutState) {
                if (aboutState is MovieDetailState) {
                  switch (aboutState.state) {
                    case ProcessStatus.loading:
                      return _buildVideoLoading();
                    case ProcessStatus.success:
                      final video = aboutState.video;
                      if (video != null && video.isNotEmpty) {
                        final youtubeId = video.firstWhere(
                          (element) =>
                              element.type == 'Teaser' ||
                              element.type == 'Trailer',
                        );
                        return YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: YoutubePlayer.convertUrlToId(
                                "https://www.youtube.com/watch?v=${youtubeId.key}")!,
                            flags: const YoutubePlayerFlags(
                              autoPlay: false,
                              mute: false,
                            ),
                          ),
                          showVideoProgressIndicator: true,
                          width: double.infinity,
                          aspectRatio: 16 / 9,
                        );
                      }
                      return SizedBox();
                    case ProcessStatus.failure:
                      return Center(child: Text("Error: ${aboutState.state}"));
                    case ProcessStatus.idle:
                    default:
                      return SizedBox();
                  }
                }
                return SizedBox();
              },
            ),
            BlocBuilder<AboutBloc, AboutState>(
              builder: (context, aboutState) {
                if (aboutState is MovieDetailState) {
                  switch (aboutState.state) {
                    case ProcessStatus.loading:
                      return _buildShimmerLoading();
                    case ProcessStatus.success:
                      final movieDetail = aboutState.movieDetail;
                      if (movieDetail != null) {
                        final listGenres = aboutState.movieDetail?.genres
                            .map((e) => e.name)
                            .join(', ');
                        final director =
                            aboutState.movieCastCrew?.crew.firstWhere(
                          (crewJob) => crewJob.job == "Director",
                        );
                        final cast = aboutState.movieCastCrew?.cast
                            .map((castName) => castName.name)
                            .join(', ');
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.secondaryColor,
                              ),
                              child: AboutMovieRating(
                                  widgetLeft: Text('8.3'),
                                  widgetRight: Text(aboutState
                                          .movieDetail?.voteAverage
                                          .toString() ??
                                      '0.0')),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 16, left: 8, right: 8),
                              child: CustomText(
                                showTabIndent: true,
                                text: movieDetail.overview,
                                customStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: AppColor.primaryTextColor),
                                collapsedMaxLines: 3,
                                textAlign: TextAlign.justify,
                                customStyleAction: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: AppColor.buttonLinerOneColor),
                              ),
                            ),
                            SizedBox(height: 8),
                            CustomLayoutLabelValue(
                              widgetLeft: Text(
                                AppLocalizations.of(context)!
                                    .keyword_certificate,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: AppColor.secondaryTextColor),
                              ),
                              widgetRight: Text('16+'),
                            ),
                            SizedBox(height: 8),
                            CustomLayoutLabelValue(
                              widgetLeft: Text(
                                AppLocalizations.of(context)!.keyword_runtime,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: AppColor.secondaryTextColor),
                              ),
                              widgetRight: Text(
                                  FormatDateTime.convertMinutesToHourMinute(
                                      movieDetail.runtime)),
                            ),
                            SizedBox(height: 8),
                            CustomLayoutLabelValue(
                              widgetLeft: Text(
                                AppLocalizations.of(context)!.keyword_release,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: AppColor.secondaryTextColor),
                              ),
                              widgetRight: Text(
                                FormatDateTime.convertFromYYYYMMDDToDDMMYYYY(
                                        movieDetail.releaseDate)
                                    .toString(),
                              ),
                            ),
                            SizedBox(height: 8),
                            CustomLayoutLabelValue(
                              widgetLeft: Text(
                                AppLocalizations.of(context)!.keyword_genre,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: AppColor.secondaryTextColor),
                              ),
                              widgetRight: Text(listGenres ?? ''),
                            ),
                            SizedBox(height: 8),
                            CustomLayoutLabelValue(
                              widgetLeft: Text(
                                AppLocalizations.of(context)!.keyword_director,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: AppColor.secondaryTextColor),
                              ),
                              widgetRight: Text(
                                director?.name ?? '',
                              ),
                            ),
                            SizedBox(height: 8),
                            CustomLayoutLabelValue(
                              widgetLeft: Text(
                                AppLocalizations.of(context)!.keyword_cast,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: AppColor.secondaryTextColor),
                              ),
                              widgetRight: CustomText(
                                text: cast ?? '',
                                customStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: AppColor.primaryTextColor),
                                collapsedMaxLines: 3,
                                textAlign: TextAlign.justify,
                                customStyleAction: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: AppColor.buttonLinerOneColor),
                              ),
                            ),
                          ],
                        );
                      }
                      return SizedBox();
                    case ProcessStatus.failure:
                      return Center(child: Text("Error: ${aboutState.state}"));
                    case ProcessStatus.idle:
                    default:
                      return SizedBox();
                  }
                }
                return SizedBox();
              },
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoLoading() {
    return Stack(
      children: [
        CustomShimmer(
          height: 180,
          width: double.infinity,
          borderRadius: 0,
          baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
          highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rating Section
        Container(
          decoration: BoxDecoration(
            color: AppColor.secondaryColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AboutMovieRating(
            widgetLeft: CustomShimmer(
              height: 16,
              width: 40,
              borderRadius: 8,
              baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
              highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
            ),
            widgetRight: CustomShimmer(
              height: 16,
              width: 40,
              borderRadius: 8,
              baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
              highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
            ),
          ),
        ),

        // Image Section
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomShimmer(
            height: 80,
            width: double.infinity,
            borderRadius: 8,
            baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
            highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
          ),
        ),

        // Text Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomShimmer(
                height: 24,
                width: 100,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
              const SizedBox(height: 8),
              CustomShimmer(
                height: 20,
                width: 140,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
              const SizedBox(height: 8),
              CustomShimmer(
                height: 20,
                width: 90,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
              const SizedBox(height: 8),
              CustomShimmer(
                height: 20,
                width: double.infinity,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
              const SizedBox(height: 8),
              CustomShimmer(
                height: 20,
                width: 250,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
              const SizedBox(height: 12),
              CustomShimmer(
                height: 50,
                width: double.infinity,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
