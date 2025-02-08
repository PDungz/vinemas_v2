import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/status_state.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/features/home/domain/use_case/now_playing_use_case.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  NowPlayingBloc() : super(NowPlayingInitial()) {
    on<NowPlayingLoadMoreEvent>(getNowPlaying);
  }

  Future<void> getNowPlaying(
      NowPlayingLoadMoreEvent event, Emitter<NowPlayingState> emit) async {
    try {
      emit(NowPlayingLoadedState(state: StatusState.loading));
      final List<Movie>? nowPlaying = await getIt<NowPlayingUseCase>()
          .getNowPlaying(movie: event.movie, page: event.page);
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
