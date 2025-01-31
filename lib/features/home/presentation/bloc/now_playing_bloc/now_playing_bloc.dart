import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/status_state.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/features/home/domain/usecase/now_playing_usecase.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  NowPlayingBloc() : super(NowPlayingInitial()) {
    on<NowPlayingEvent>(getNowPlaying);
  }

  Future<void> getNowPlaying(
      NowPlayingEvent event, Emitter<NowPlayingState> emit) async {
    try {
      emit(NowPlayingLoadedState(state: StatusState.loading));
      final List<Movie>? nowPlaying =
          await getIt<NowPlayingUseCase>().getNowPlaying();
      emit(NowPlayingLoadedState(
          state: StatusState.success, nowPlaying: nowPlaying ?? []));
    } catch (e) {
      printE("[Get Now Playing Bloc] error: $e");
      emit(NowPlayingLoadedState(
        state: StatusState.failure,
        errorMsg: e.toString(),
      ));
    }
  }
}
