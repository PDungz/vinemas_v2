part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NowPlayingInitial extends NowPlayingState {}

class NowPlayingLoadedState extends NowPlayingState {
  final ProcessStatus state;
  final List<Movie>? nowPlaying;
  final String? errorMsg;
  final bool loadingMore; // Thêm biến này để kiểm tra có đang tải thêm dữ liệu không

  NowPlayingLoadedState({
    this.state = ProcessStatus.idle,
    this.nowPlaying,
    this.errorMsg,
    this.loadingMore = false,
  });

  @override
  List<Object?> get props => [
        state,
        nowPlaying,
        errorMsg,
        loadingMore,
      ];

  NowPlayingLoadedState copyWith({
    ProcessStatus? state,
    List<Movie>? nowPlaying,
    String? errorMsg,
    bool? loadingMore,
  }) {
    return NowPlayingLoadedState(
      state: state ?? this.state,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      errorMsg: errorMsg ?? this.errorMsg,
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }
}
