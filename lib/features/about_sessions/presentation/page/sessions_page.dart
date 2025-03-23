import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/bloc/about_bloc/about_bloc.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/session/session_cinema_schedule_movie_loading_widget.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/session/session_cinema_schedule_movie_widget.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/session/session_cinema_widget.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/session/session_filter_day_widget.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/session/session_title_cinema_location_widget.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({super.key, required this.movie});
  final Movie movie;
  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  CinemaBand? selectedCinemaBand;
  DateTime selectedDate = DateTime.now();
  String selectedTimeInterval = 'Tất cả';

  void updateCinemaBand(CinemaBand cinemaBand) {
    setState(() {
      selectedCinemaBand = cinemaBand;
    });
  }

  void updateFilter(DateTime date, String timeInterval) {
    setState(() {
      selectedDate = date;
      selectedTimeInterval = timeInterval;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SessionBloc()..add(SessionInitialEvent())),
        BlocProvider(
            create: (context) =>
                AboutBloc()..add(MovieDetailEvent(movieId: widget.movie.id))),
      ],
      child: Padding(
        padding: const EdgeInsets.only(top: 104),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 86,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(
                        $AssetsImagesBackgroundGen().coverHorizontal.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _HeaderDelegate(
                onFilterChanged: updateFilter,
              ),
            ),
            SliverToBoxAdapter(
              child: SessionCinemaWidget(onCinemaSelected: updateCinemaBand),
            ),
            SliverToBoxAdapter(
              child: SessionTitleCinemaLocationWidget(),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<AboutBloc, AboutState>(
                builder: (context, state) {
                  if (state is MovieDetailState) {
                    final movieDetail = state.movieDetail;
                    if (state.state == ProcessStatus.success &&
                        movieDetail != null) {
                      return SessionCinemaScheduleMovieWidget(
                        cinemaBand: selectedCinemaBand,
                        selectedDate: selectedDate,
                        selectedTimeInterval: selectedTimeInterval,
                        movieDetail: movieDetail,
                      );
                    }
                  }
                  return SessionCinemaScheduleMovieLoadingWidget();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Function(DateTime, String) onFilterChanged;

  _HeaderDelegate({required this.onFilterChanged});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SessionFilterDayWidget(onFilterChanged: onFilterChanged);
  }

  @override
  double get maxExtent => 116;

  @override
  double get minExtent => 116;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
