// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ticket_bloc.dart';

abstract class TicketState extends Equatable {}

class TicketInitial extends TicketState {
  @override
  List<Object?> get props => [];
}

class TicketMovieState extends TicketState {
  final ProcessStatus processStatus;
  final List<Ticket>? tickets;
  final String? message;

  TicketMovieState({
    this.processStatus = ProcessStatus.idle,
    this.tickets,
    this.message,
  });

  @override
  List<Object?> get props => [processStatus, tickets, message];

  TicketMovieState copyWith({
    ProcessStatus? processStatus,
    List<Ticket>? tickets,
    String? message,
  }) {
    return TicketMovieState(
      processStatus: processStatus ?? this.processStatus,
      tickets: tickets ?? this.tickets,
      message: message ?? this.message,
    );
  }
}

class SeatMovieTicketState extends TicketState {
  final ProcessStatus processStatus;
  final List<String>? seats;
  final String? message;

  SeatMovieTicketState({
    this.processStatus = ProcessStatus.idle,
    this.seats,
    this.message,
  });

  @override
  List<Object?> get props => [processStatus, seats, message];

  SeatMovieTicketState copyWith({
    ProcessStatus? processStatus,
    List<String>? seats,
    String? message,
  }) {
    return SeatMovieTicketState(
      processStatus: processStatus ?? this.processStatus,
      seats: seats ?? this.seats,
      message: message ?? this.message,
    );
  }
}
