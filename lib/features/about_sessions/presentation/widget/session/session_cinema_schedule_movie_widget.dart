import 'package:flutter/material.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/session/session_title_cinema_movie_widget.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';

class SessionCinemaScheduleMovieWidget extends StatefulWidget {
  const SessionCinemaScheduleMovieWidget(
      {super.key,
      required this.cinemaBand,
      required this.selectedDate,
      required this.selectedTimeInterval,
      required this.movie});
  final CinemaBand? cinemaBand;
  final DateTime selectedDate;
  final String selectedTimeInterval;
  final Movie movie;
  @override
  State<SessionCinemaScheduleMovieWidget> createState() =>
      _SessionCinemaScheduleMovieWidgetState();
}

class _SessionCinemaScheduleMovieWidgetState
    extends State<SessionCinemaScheduleMovieWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 20),
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: AppColor.secondaryColor,
          borderRadius: BorderRadius.circular(8)),
      child: SessionTitleCinemaMovieWidget(
        cinemaBand: widget.cinemaBand,
        selectedDate: widget.selectedDate,
        selectedTimeInterval: widget.selectedTimeInterval,
        movie: widget.movie,
      ),
    );
  }
}
