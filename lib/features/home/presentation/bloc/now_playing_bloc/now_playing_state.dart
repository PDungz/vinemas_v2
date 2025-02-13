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

  NowPlayingLoadedState({
    this.state = ProcessStatus.idle,
    this.nowPlaying,
    this.errorMsg,
  });

  @override
  List<Object?> get props => [
        state,
        nowPlaying,
        errorMsg,
      ];

  NowPlayingLoadedState copyWith({
    ProcessStatus? state,
    List<Movie>? nowPlaying,
    String? errorMsg,
  }) {
    return NowPlayingLoadedState(
      state: state ?? this.state,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
