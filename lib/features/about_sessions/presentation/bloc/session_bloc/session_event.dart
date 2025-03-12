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

class SessionSessionMovieEvent extends SessionEvent {
  final String sessionMovieId;
  SessionSessionMovieEvent({
    required this.sessionMovieId,
  });

  @override
  List<Object?> get props => [];
}
