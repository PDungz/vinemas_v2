// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NowPlayingInitialEvent extends NowPlayingEvent {}

class NowPlayingLoadEvent extends NowPlayingEvent {}

class NowPlayingLoadMoreEvent extends NowPlayingEvent {
  final List<Movie> movie;
  final int page;

  NowPlayingLoadMoreEvent({
    required this.movie,
    required this.page,
  });
}
