// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {}

class NowPlayingInitialEvent extends NowPlayingEvent {
  @override
  List<Object?> get props => [];
}

class NowPlayingLoadEvent extends NowPlayingEvent {
  @override
  List<Object?> get props => [];
}

class NowPlayingLoadMoreEvent extends NowPlayingEvent {
  final List<Movie> movie;
  final int page;

  NowPlayingLoadMoreEvent({
    required this.movie,
    required this.page,
  });

  @override
  List<Object?> get props => [movie, page];
}

class NowPlayingSearchLoadMoreEvent extends NowPlayingEvent {
  final List<Movie> movie;
  final int page;

  NowPlayingSearchLoadMoreEvent({
    required this.movie,

    required this.page,
  });

  @override
  List<Object?> get props =>
      [movie, page];

  NowPlayingSearchLoadMoreEvent copyWith({
    List<Movie>? movie,
    int? page,
  }) {
    return NowPlayingSearchLoadMoreEvent(
      movie: movie ?? this.movie,
      page: page ?? this.page,
    );
  }
}
