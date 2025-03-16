// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {}

class SessionInitialEvent extends SessionEvent {
  @override
  List<Object?> get props => [];
}

class SessionCinemaAndSessionMovieEvent extends SessionEvent {
  @override
  List<Object?> get props => [];
}

class SessionCinemaEvent extends SessionEvent {
  @override
  List<Object?> get props => [];
}

class CreatSessionCinemaEvent extends SessionEvent {
  final Movie movie;
  CreatSessionCinemaEvent({
    required this.movie,
  });

  @override
  List<Object?> get props => [movie];

  CreatSessionCinemaEvent copyWith({
    Movie? movie,
  }) {
    return CreatSessionCinemaEvent(
      movie: movie ?? this.movie,
    );
  }
}

class SessionSessionMovieEvent extends SessionEvent {
  final String sessionMovieId;
  SessionSessionMovieEvent({
    required this.sessionMovieId,
  });

  @override
  List<Object?> get props => [];
}
