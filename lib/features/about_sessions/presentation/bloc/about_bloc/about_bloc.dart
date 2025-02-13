import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/movie_cast_crew.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/video.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/cast_use_case.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/movie_detail_use_case.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/video_use_case.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutInitial()) {
    on<MovieDetailEvent>(getMovieDetail);
  }

  Future<void> getMovieDetail(
      MovieDetailEvent event, Emitter<AboutState> emit) async {
    try {
      emit(MovieDetailState(state: ProcessStatus.loading));
      final List<Video>? video =
          await getIt<VideoUseCase>().getVideo(movieId: event.movieId);
      final MovieCastCrew? movieCastCrew =
          await getIt<CastUseCase>().getCast(movieId: event.movieId);
      final MovieDetail? movieDetail = await getIt<MovieDetailUseCase>()
          .getMovieDetail(movieId: event.movieId);
      emit(
        MovieDetailState(
          state: ProcessStatus.success,
          movieDetail: movieDetail,
          movieCastCrew: movieCastCrew,
          video: video,
        ),
      );
    } catch (e) {
      printE("[Get Movie Detail Bloc] error: $e");
      emit(MovieDetailState(
        state: ProcessStatus.failure,
        errorMsg: e.toString(),
      ));
    }
  }
}
