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
  final String? keySearch;
  final List<int>? genreIds;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int page;

  NowPlayingSearchLoadMoreEvent({
    required this.movie,
    this.keySearch,
    this.genreIds,
    this.fromDate,
    this.toDate,
    required this.page,
  });

  @override
  List<Object?> get props =>
      [movie, keySearch, genreIds, fromDate, toDate, page];

  NowPlayingSearchLoadMoreEvent copyWith({
    List<Movie>? movie,
    String? keySearch,
    List<int>? genreIds,
    DateTime? fromDate,
    DateTime? toDate,
    int? page,
  }) {
    return NowPlayingSearchLoadMoreEvent(
      movie: movie ?? this.movie,
      keySearch: keySearch ?? this.keySearch,
      genreIds: genreIds ?? this.genreIds,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      page: page ?? this.page,
    );
  }
}
