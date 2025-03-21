// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {}

class TicketMovieEvent extends TicketEvent {
  @override
  List<Object?> get props => [];
}

class TicketMovieDetailEvent extends TicketEvent {
  final Ticket ticket;

  TicketMovieDetailEvent({
    required this.ticket,
  });
  @override
  List<Object?> get props => [ticket];

  TicketMovieDetailEvent copyWith({
    Ticket? ticket,
  }) {
    return TicketMovieDetailEvent(
      ticket: ticket ?? this.ticket,
    );
  }
}

class UserMovieTicketEvent extends TicketEvent {
  final String sessionMovieId;
  UserMovieTicketEvent({
    required this.sessionMovieId,
  });

  @override
  List<Object?> get props => [];
}

class ChangeTichetEvent extends TicketEvent {
  final TicketModel ticketModel;
  final SessionMovie sessionMovie;
  final List<String> seats;
  ChangeTichetEvent({
    required this.ticketModel,
    required this.sessionMovie,
    required this.seats,
  });

  @override
  List<Object?> get props => [ticketModel, sessionMovie, seats];

  ChangeTichetEvent copyWith({
    TicketModel? ticketModel,
    SessionMovie? sessionMovie,
    List<String>? seats,
  }) {
    return ChangeTichetEvent(
      ticketModel: ticketModel ?? this.ticketModel,
      sessionMovie: sessionMovie ?? this.sessionMovie,
      seats: seats ?? this.seats,
    );
  }
}
