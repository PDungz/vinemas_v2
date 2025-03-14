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
