// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upcoming_bloc.dart';

abstract class UpcomingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpcomingInitialEvent extends UpcomingEvent {}

class UpcomingLoadEvent extends UpcomingEvent {}
