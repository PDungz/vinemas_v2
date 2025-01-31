part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NowPlayingInitialEvent extends NowPlayingEvent {}

class NowPlayingLoadEvent extends NowPlayingEvent {}
