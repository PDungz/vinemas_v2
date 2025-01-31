// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upcoming_bloc.dart';

abstract class UpcomingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpcomingInitial extends UpcomingState {}

class UpcomingLoadedState extends UpcomingState {
  final StatusState state;
  final List<Movie>? upcoming;
  final String? errorMsg;

  UpcomingLoadedState({
    this.state = StatusState.idle,
    this.upcoming,
    this.errorMsg,
  });

  @override
  List<Object?> get props => [
        state,
        upcoming,
        errorMsg,
      ];

  UpcomingLoadedState copyWith({
    StatusState? state,
    List<Movie>? upcoming,
    String? errorMsg,
  }) {
    return UpcomingLoadedState(
      state: state ?? this.state,
      upcoming: upcoming ?? this.upcoming,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
