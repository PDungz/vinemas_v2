import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/session/session_cinema_recommend_widget.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/session/session_cinema_schedule_movie_loading_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

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
                      List<SessionMovie> sessionMovieCinema = listSessionMovie
                          .where((element) =>
                              cinemas[index].cinemaId == element.cinemaId &&
                              element.endDate.isAfter(
                                  DateTime.now())) // Lọc bỏ suất chiếu đã qua
                          .toList()
                        ..sort((a, b) =>
                            a.endDate.compareTo(b.endDate)); // Sắp xếp theo giờ

                      final chairConfig = state.chairConfigs?.firstWhere(
                        (element) =>
                            element.chairConfigId ==
                            cinemas[index].chairConfigId,
                      );
                      if (chairConfig != null) {
                        return SessionCinemaRecommendWidget(
                          cinema: cinemas[index],
                          chairConfig: chairConfig,
                          cinemaBand: widget.cinemaBand!,
                          currentCinemaIndex: currentCinemaIndex,
                          index: index,
                          movieDetail: widget.movieDetail,
                          sessionMovieCinema: sessionMovieCinema,
                        );
                      }
                      return SessionCinemaScheduleMovieLoadingWidget();
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
