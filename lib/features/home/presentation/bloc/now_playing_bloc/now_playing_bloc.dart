import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
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
      final currentState = state;
      List<Movie> existingMovies = [];

      if (currentState is NowPlayingLoadedState) {
        existingMovies = List.from(currentState.nowPlaying ?? []);

        // Cập nhật trạng thái là đang load thêm dữ liệu
        emit(currentState.copyWith(loadingMore: true));
      }

      final List<Movie>? newMovies =
          await getIt<NowPlayingUseCase>().getNowPlaying(page: event.page);

      if (newMovies != null && newMovies.isNotEmpty) {
        existingMovies.addAll(newMovies);
      }

      emit(NowPlayingLoadedState(
        state: ProcessStatus.success,
        nowPlaying: existingMovies,
        loadingMore: false, // Load xong thì tắt loading
      ));
    } catch (e) {
      printE("[Get Now Playing Bloc] error: $e");
      emit(NowPlayingLoadedState(
        state: ProcessStatus.failure,
        errorMsg: e.toString(),
        nowPlaying: (state as NowPlayingLoadedState?)?.nowPlaying,
        loadingMore: false, // Nếu lỗi cũng phải tắt loading
      ));
    }
  }
}
