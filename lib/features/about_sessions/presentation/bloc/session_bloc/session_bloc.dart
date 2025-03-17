import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/about/movie_detail_use_case.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/session/session_use_case.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(SessionInitial()) {
    on<SessionInitialEvent>(getCinemaBand);
    on<SessionCinemaEvent>(getCinema);
    on<SessionSessionMovieEvent>(getSessionMovie);
    on<SessionCinemaAndSessionMovieEvent>(getCinemaAndSessionMovie);
    on<CreatSessionCinemaEvent>(createSessionMovie);
  }

  Future<void> getCinemaBand(
      SessionInitialEvent event, Emitter<SessionState> emit) async {
    try {
      emit(SessionCinemaBandState(state: ProcessStatus.loading));

      await getIt<SessionUseCase>().getCinemaBand(
        onPressed: ({required cinemaBand, required message, required status}) {
          emit(SessionCinemaBandState(
              state: status, cinemaBands: cinemaBand, message: message));
        },
      );
    } catch (e) {
      emit(SessionCinemaBandState(
        state: ProcessStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> getCinemaAndSessionMovie(SessionCinemaAndSessionMovieEvent event,
      Emitter<SessionState> emit) async {
    try {
      emit(SessionCinemaAndSessionMovieState(state: ProcessStatus.loading));
      List<SessionMovie>? sessionMovieBloc;
      List<Cinema>? cinemaBloc;
      List<ChairConfig>? chairConfigsBloc;
      String? messageBloc;
      ProcessStatus statusBloc = ProcessStatus.failure;
      await getIt<SessionUseCase>().getCinema(
        onPressed: ({required cinema, required message, required status}) {
          cinemaBloc = cinema;
          messageBloc = message;
          statusBloc = status;
        },
      );
      await getIt<SessionUseCase>().getSessionMovie(
        onPressed: (
            {required sessionMovie, required message, required status}) {
          sessionMovieBloc = sessionMovie;
          messageBloc = message;
          statusBloc = status;
        },
      );

      await getIt<SessionUseCase>().getChairConfig(
        onPressed: ({required chairConfig, required message, required status}) {
          chairConfigsBloc = chairConfig;
          messageBloc = message;
          statusBloc = status;
        },
      );
      emit(SessionCinemaAndSessionMovieState(
          state: statusBloc,
          sessionMovie: sessionMovieBloc,
          cinemas: cinemaBloc,
          chairConfigs: chairConfigsBloc,
          message: messageBloc));
    } catch (e) {
      emit(SessionCinemaAndSessionMovieState(
        state: ProcessStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> getCinema(
      SessionCinemaEvent event, Emitter<SessionState> emit) async {
    try {
      emit(SessionCinemaState(state: ProcessStatus.loading));

      await getIt<SessionUseCase>().getCinema(
        onPressed: ({required cinema, required message, required status}) {
          emit(SessionCinemaState(
              state: status, cinemas: cinema, message: message));
        },
      );
    } catch (e) {
      emit(SessionCinemaState(
        state: ProcessStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> getSessionMovie(
      SessionSessionMovieEvent event, Emitter<SessionState> emit) async {
    try {
      emit(SessionSessionMovieState(state: ProcessStatus.loading));

      await getIt<SessionUseCase>().getSessionMovie(
        onPressed: (
            {required sessionMovie, required message, required status}) {
          final sessionMovieCinema = sessionMovie?.firstWhere(
            (element) => element.sessionMovieId == event.sessionMovieId,
          );
          emit(SessionSessionMovieState(
              state: status,
              sessionMovie: sessionMovieCinema,
              message: message));
        },
      );
    } catch (e) {
      emit(SessionSessionMovieState(
        state: ProcessStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> createSessionMovie(
      CreatSessionCinemaEvent event, Emitter<SessionState> state) async {
    try {
      List<CinemaBand> cinemaBands = [];
      List<Cinema> cinemas = [];
      List<SessionMovie> sessionMovies = [];

      await getIt<SessionUseCase>().getCinemaBand(
        onPressed: ({required cinemaBand, required message, required status}) {
          cinemaBands = cinemaBand ?? [];
        },
      );

      await getIt<SessionUseCase>().getCinema(
        onPressed: ({required cinema, required message, required status}) {
          cinemas = cinema ?? [];
        },
      );

      await getIt<SessionUseCase>().getSessionMovie(
        onPressed: (
            {required message, required sessionMovie, required status}) {
          sessionMovies = sessionMovie ?? [];
        },
      );

      final movieDetail = await getIt<MovieDetailUseCase>()
          .getMovieDetail(movieId: event.movie.id);

      final now = DateTime.now();
      final runtime = movieDetail?.runtime ??
          120; // Nếu không có runtime, mặc định là 120 phút

      final startDate = DateTime(now.year, now.month, now.day, now.hour, 0);
      final endDate =
          startDate.add(Duration(minutes: ((runtime + 29) ~/ 30) * 30));

      for (var cinemaBand in cinemaBands) {
        for (var cinema in cinemas) {
          if (cinema.cinemaBandId == cinemaBand.cinemaBandId) {
            // Lấy danh sách suất chiếu hiện có của phim này tại rạp hiện tại
            final existingSessions = sessionMovies.where(
              (session) =>
                  session.movieId == event.movie.id &&
                  session.cinemaId == cinema.cinemaId,
            );

            // Kiểm tra nếu thời gian của suất chiếu mới bị trùng với bất kỳ suất chiếu nào đã tồn tại
            bool isOverlapping = existingSessions.any(
              (existingSession) => startDate.isBefore(existingSession.endDate),
            );

            if (!isOverlapping) {
              await getIt<SessionUseCase>().createSessionMovie(
                sessionMovie: SessionMovie(
                  sessionMovieId: '',
                  movieId: event.movie.id,
                  cinemaId: cinema.cinemaId,
                  startDate: startDate,
                  endDate: endDate,
                  description: '',
                  seatPrices: {
                    'regular': 120000,
                    'vip': 180000,
                    'sweetBox': 250000,
                  },
                  chairStatuses: {},
                ),
              );
            }
          }
        }
      }
    } catch (e) {
      printE("Session Bloc: $e");
    }
  }
}
