import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/session/session_use_case.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(SessionInitial()) {
    on<SessionInitialEvent>(getCinemaBand);
    on<SessionCinemaEvent>(getCinema);
    on<SessionSessionMovieEvent>(getSessionMovie);
    on<SessionCinemaAndSessionMovieEvent>(getCinemaAndSessionMovie);
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
}
