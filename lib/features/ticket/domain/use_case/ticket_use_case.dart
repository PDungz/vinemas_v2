// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';
import 'package:vinemas_v1/features/ticket/domain/repository/ticket_repository.dart';

class TicketUseCase {
  final TicketRepository ticketRepository;
  TicketUseCase({
    required this.ticketRepository,
  });

  Future<Ticket?> bookTicket(
      {required Ticket ticket,
      required Function(
              {required String message, required ProcessStatus status})
          onPressed}) async {
    return await ticketRepository.bookTicket(
        ticket: ticket, onPressed: onPressed);
  }

  Future<List<Ticket>?> getTickets() async {
    return ticketRepository.getTickets();
  }

  Future<void> updateBookTicket({
    required Ticket ticket,
    required Function({
      required String message,
      required ProcessStatus status,
    }) onPressed,
  }) async {
    try {
      await ticketRepository.updateBookTicket(ticket: ticket);
      onPressed(
          message: "Ticket updated successfully",
          status: ProcessStatus.success);
    } catch (e) {
      onPressed(
          message: "Failed to update ticket: ${e.toString()}",
          status: ProcessStatus.failure);
    }
  }
}
