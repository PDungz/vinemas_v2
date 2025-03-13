import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Card/custom_card.dart';
import 'package:packages/widget/Dialog/custom_dialog.dart';
import 'package:packages/widget/Layout/custom_layout_label_value.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:packages/widget/Shimmer/custom_shimmer.dart';
import 'package:packages/widget/Text/custom_text.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/bloc/about_bloc/about_bloc.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/about/about_loading_widget.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/about/about_movie_rating.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AboutPage extends StatelessWidget {
  const AboutPage(
      {super.key, required this.movie, required this.onSelectSession});

  final Movie movie;
  final VoidCallback onSelectSession; // Nhận callback từ AboutSessionsPage

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutBloc>(
      create: (context) =>
          AboutBloc()..add(MovieDetailEvent(movieId: movie.id)),
      child: Stack(
        children: [
          SingleChildScrollView(
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
                          return Center(
                              child: Text("Error: ${aboutState.state}"));
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
                          return AboutLoadingWidget();
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
                                              .toStringAsFixed(1) ??
                                          '0.0')),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 16, left: 8, right: 8),
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
                                            color:
                                                AppColor.buttonLinerOneColor),
                                  ),
                                ),
                                SizedBox(height: 8),
                                _buildContent(
                                    context: context,
                                    leftTitle: AppLocalizations.of(context)!
                                        .keyword_certificate,
                                    widgetContent: Text('16+')),
                                SizedBox(height: 8),
                                _buildContent(
                                    context: context,
                                    leftTitle: AppLocalizations.of(context)!
                                        .keyword_runtime,
                                    widgetContent: Text(FormatDateTime
                                        .convertMinutesToHourMinute(
                                            movieDetail.runtime))),
                                SizedBox(height: 8),
                                _buildContent(
                                    context: context,
                                    leftTitle: AppLocalizations.of(context)!
                                        .keyword_release,
                                    widgetContent: Text(
                                      FormatDateTime
                                              .convertFromYYYYMMDDToDDMMYYYY(
                                                  movieDetail.releaseDate)
                                          .toString(),
                                    )),
                                SizedBox(height: 8),
                                _buildContent(
                                    context: context,
                                    leftTitle: AppLocalizations.of(context)!
                                        .keyword_genre,
                                    widgetContent: Text(listGenres ?? '')),
                                SizedBox(height: 8),
                                _buildContent(
                                    context: context,
                                    leftTitle: AppLocalizations.of(context)!
                                        .keyword_director,
                                    widgetContent: Text(
                                      director?.name ?? '',
                                    )),
                                SizedBox(height: 8),
                                _buildContent(
                                  context: context,
                                  leftTitle: AppLocalizations.of(context)!
                                      .keyword_cast,
                                  widgetContent: CustomText(
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
                                            color:
                                                AppColor.buttonLinerOneColor),
                                  ),
                                ),
                              ],
                            );
                          }
                          return SizedBox();
                        case ProcessStatus.failure:
                          return Center(
                              child: Text("Error: ${aboutState.state}"));
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
          BlocProvider(
            create: (context) => UserBloc()..add(isUserLoggedInEvent()),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomCard(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    borderRadius: BorderRadius.circular(0.0),
                    backgroundColor: AppColor.secondaryColor,
                    child: CustomShadow(
                      child: CustomButton(
                          label: AppLocalizations.of(context)!
                              .keyword_select_session,
                          onPressed: () {
                            if (state is isUserLoggedInState &&
                                state.isUserLoggedIn == true) {
                              onSelectSession();
                            } else {
                              Get.dialog(CustomDialog(
                                title: AppLocalizations.of(context)!
                                    .keyword_notification,
                                description: AppLocalizations.of(context)!
                                    .keyword_notification_login_required,
                                acceptText: AppLocalizations.of(context)!
                                    .keyword_confirm,
                                cancelText: AppLocalizations.of(context)!
                                    .keyword_cancel,
                                onAccept: () {
                                  Get.toNamed(ConfigRoute.loginPage);
                                },
                              ));
                            }
                          }),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
    required String leftTitle,
    required Widget widgetContent,
  }) {
    return CustomLayoutLabelValue(
      widgetLeft: Text(
        leftTitle,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: AppColor.secondaryTextColor),
      ),
      widgetRight: widgetContent,
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
}
