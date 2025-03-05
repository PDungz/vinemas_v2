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
  @override
  List<Object?> get props => [];
}
