import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:packages/widget/Divider/custom_divider.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:packages/widget/Layout/custom_layout_vertical.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/session/session_cinema_schedule_movie_loading_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class SessionTitleCinemaMovieWidget extends StatefulWidget {
  const SessionTitleCinemaMovieWidget({
    super.key,
    required this.cinemaBand,
    required this.selectedDate,
    required this.selectedTimeInterval,
    required this.movieDetail,
  });
  final CinemaBand? cinemaBand;
  final DateTime selectedDate;
  final String selectedTimeInterval;
  final MovieDetail movieDetail;

  @override
  State<SessionTitleCinemaMovieWidget> createState() =>
      _SessionTitleCinemaMovieState();
}

class _SessionTitleCinemaMovieState
    extends State<SessionTitleCinemaMovieWidget> {
  List<int> currentCinemaIndex = [0];

  @override
  Widget build(BuildContext context) {
    // final String nameMovie = widget.movie.title;
    return BlocProvider(
      create: (context) =>
          SessionBloc()..add(SessionCinemaAndSessionMovieEvent()),
      child: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          if (state is SessionCinemaAndSessionMovieState) {
            switch (state.state) {
              case ProcessStatus.loading:
                return SessionCinemaScheduleMovieLoadingWidget();
              case ProcessStatus.success:
                final cinemas = state.cinemas
                    ?.where(
                      (element) =>
                          element.cinemaBandId ==
                          widget.cinemaBand?.cinemaBandId,
                    )
                    .toList();
                final listSessionMovie = state.sessionMovie
                    ?.where(
                  (element) => element.movieId == widget.movieDetail.id,
                )
                    .where((element) {
                  DateTime movieStartDate = element.startDate;
                  DateTime movieEndDate = element.endDate;

                  // Lọc theo ngày
                  bool isInDateRange =
                      widget.selectedDate.year == movieStartDate.year &&
                          widget.selectedDate.month == movieStartDate.month &&
                          widget.selectedDate.day == movieStartDate.day;

                  // Nếu khoảng thời gian là 'Tất cả', không cần lọc tiếp
                  if (widget.selectedTimeInterval == 'Tất cả') {
                    return isInDateRange;
                  }

                  List<String> parts = widget.selectedTimeInterval.split(' - ');
                  int startHourFilter = int.parse(parts[0].replaceAll(":", ""));
                  int endHourFilter = int.parse(parts[1].replaceAll(":", ""));

                  int movieStartTime = int.parse(
                      FormatDateTime.formatToHourMinute(movieStartDate)
                          .replaceAll(":", ""));
                  int movieEndTime = int.parse(
                      FormatDateTime.formatToHourMinute(movieEndDate)
                          .replaceAll(":", ""));
                  bool isInTimeRange = movieStartTime >= startHourFilter &&
                      movieEndTime < endHourFilter;

                  return isInDateRange && isInTimeRange;
                }).toList();

                if (cinemas != null &&
                    listSessionMovie != null &&
                    cinemas.isNotEmpty &&
                    listSessionMovie.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cinemas.length,
                    itemBuilder: (context, index) {
                      List<SessionMovie> sessionMovieCinema =
                          listSessionMovie.where(
                        (element) {
                          return cinemas[index].cinemaId == element.cinemaId;
                        },
                      ).toList();
                      final chairConfig = state.chairConfigs?.firstWhere(
                        (element) =>
                            element.chairConfigId ==
                            cinemas[index].chairConfigId,
                      );
                      if (chairConfig != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomLayoutHorizontal(
                              verticalPadding: 0,
                              horizontalPadding: 0,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              leftWidget: CustomLayoutHorizontal(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                leftWidget: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppColor.buttonLinerOneColor,
                                          width: 1.2),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          widget.cinemaBand?.imageUrl ?? '',
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                rightWidget: CustomLayoutVertical(
                                  topWidget: Text(cinemas[index].nameCinema,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                  bottomWidget: Text('Bạn ở gần đây',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ),
                              ),
                              rightWidget: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CustomIconButton(
                                    elevation: 0,
                                    size: 16,
                                    horizontalPadding: 0,
                                    svgPathUp: currentCinemaIndex
                                            .contains(index)
                                        ? $AssetsIconsGen().iconApp.angleUp
                                        : $AssetsIconsGen().iconApp.expandArrow,
                                    onPressed: () {
                                      if (currentCinemaIndex.contains(index)) {
                                        setState(() {
                                          currentCinemaIndex.remove(index);
                                        });
                                      } else {
                                        setState(() {
                                          currentCinemaIndex.add(index);
                                        });
                                      }
                                    }),
                              ),
                            ),
                            Visibility(
                              visible: currentCinemaIndex.contains(index),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(cinemas[index].address,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        ),
                                        GestureDetector(
                                          child: Text('Tìm Đường',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: AppColor
                                                          .buttonLinerOneColor)),
                                        )
                                      ],
                                    ).marginSymmetric(horizontal: 8),
                                    Wrap(
                                      alignment:
                                          WrapAlignment.start, // Căn trái
                                      children: [
                                        ...sessionMovieCinema.map(
                                          (session) {
                                            return IntrinsicWidth(
                                              child: GestureDetector(
                                                onTap: () => Get.toNamed(
                                                  ConfigRoute
                                                      .seatReservationPage,
                                                  arguments: [
                                                    session,
                                                    widget.movieDetail,
                                                    chairConfig,
                                                    cinemas[index],
                                                  ],
                                                ),
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                                  padding: EdgeInsets.all(1),
                                                  decoration: BoxDecoration(
                                                    color: AppColor
                                                        .buttonLinerOneColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColor
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          "${FormatDateTime.formatToHourMinute(session.startDate)} - ${FormatDateTime.formatToHourMinute(session.endDate)}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.copyWith(
                                                                    color: AppColor
                                                                        .buttonLinerOneColor,
                                                                  ),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          '${AppLocalizations.of(context)!.keyword_remaining} ${chairConfig.rowCount * chairConfig.seatsPerRow - session.chairStatuses.length}/${chairConfig.rowCount * chairConfig.seatsPerRow}'
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: CustomDivider(
                                color: AppColor.accentColor,
                              ),
                            )
                          ],
                        );
                      }
                      return null;
                    },
                  );
                }
              default:
                return Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 12),
                  child: SvgPicture.asset(
                    $AssetsSvgGen().popcorn,
                    height: 54,
                    fit: BoxFit.contain,
                  ),
                );
            }
          }
          return Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 12),
            child: SvgPicture.asset(
              $AssetsSvgGen().popcorn,
              height: 54,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
