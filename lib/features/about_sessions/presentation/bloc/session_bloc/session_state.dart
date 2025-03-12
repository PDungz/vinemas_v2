// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'session_bloc.dart';

abstract class SessionState extends Equatable {}

class SessionInitial extends SessionState {
  @override
  List<Object?> get props => [];
}

class SessionCinemaAndSessionMovieState extends SessionState {
  final ProcessStatus state;
  final List<Cinema>? cinemas;
  final List<SessionMovie>? sessionMovie;
  final List<ChairConfig>? chairConfigs;
  final String? message;

  SessionCinemaAndSessionMovieState({
    this.state = ProcessStatus.idle,
    this.cinemas,
    this.sessionMovie,
    this.chairConfigs,
    this.message,
  });

  @override
  List<Object?> get props =>
      [state, sessionMovie, cinemas, chairConfigs, message];

  SessionCinemaAndSessionMovieState copyWith({
    ProcessStatus? state,
    List<Cinema>? cinemas,
    List<SessionMovie>? sessionMovie,
    List<ChairConfig>? chairConfigs,
    String? message,
  }) {
    return SessionCinemaAndSessionMovieState(
      state: state ?? this.state,
      cinemas: cinemas ?? this.cinemas,
      sessionMovie: sessionMovie ?? this.sessionMovie,
      chairConfigs: chairConfigs ?? this.chairConfigs,
      message: message ?? this.message,
    );
  }
}

class SessionCinemaBandState extends SessionState {
  final ProcessStatus state;
  final List<CinemaBand>? cinemaBands;
  final String? message;

  SessionCinemaBandState({
    this.state = ProcessStatus.idle,
    this.cinemaBands,
    this.message,
  });

  @override
  List<Object?> get props => [state, cinemaBands, message];

  SessionCinemaBandState copyWith({
    ProcessStatus? state,
    List<CinemaBand>? cinemaBands,
    String? message,
  }) {
    return SessionCinemaBandState(
      state: state ?? this.state,
      cinemaBands: cinemaBands ?? this.cinemaBands,
      message: message ?? this.message,
    );
  }
}

class SessionCinemaState extends SessionState {
  final ProcessStatus state;
  final List<Cinema>? cinemas;
  final String? message;

  SessionCinemaState({
    this.state = ProcessStatus.idle,
    this.cinemas,
    this.message,
  });

  @override
  List<Object?> get props => [state, cinemas, message];

  SessionCinemaState copyWith({
    ProcessStatus? state,
    List<Cinema>? cinemas,
    String? message,
  }) {
    return SessionCinemaState(
      state: state ?? this.state,
      cinemas: cinemas ?? this.cinemas,
      message: message ?? this.message,
    );
  }
}

class SessionChairConfigState extends SessionState {
  final ProcessStatus state;
  final List<ChairConfig>? chairConfigs;
  final String? message;

  SessionChairConfigState({
    this.state = ProcessStatus.idle,
    this.chairConfigs,
    this.message,
  });

  @override
  List<Object?> get props => [state, chairConfigs, message];

  SessionChairConfigState copyWith({
    ProcessStatus? state,
    List<ChairConfig>? chairConfigs,
    String? message,
  }) {
    return SessionChairConfigState(
      state: state ?? this.state,
      chairConfigs: chairConfigs ?? this.chairConfigs,
      message: message ?? this.message,
    );
  }
}

class SessionSessionMovieState extends SessionState {
  final ProcessStatus state;
  final SessionMovie? sessionMovie;
  final String? message;

  SessionSessionMovieState({
    this.state = ProcessStatus.idle,
    this.sessionMovie,
    this.message,
  });

  @override
  List<Object?> get props => [state, sessionMovie, message];

  SessionSessionMovieState copyWith({
    ProcessStatus? state,
    SessionMovie? sessionMovie,
    String? message,
  }) {
    return SessionSessionMovieState(
      state: state ?? this.state,
      sessionMovie: sessionMovie ?? this.sessionMovie,
      message: message ?? this.message,
    );
  }
}
