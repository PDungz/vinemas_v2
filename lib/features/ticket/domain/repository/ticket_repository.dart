import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';

abstract class TicketRepository {
  Future<Ticket?> bookTicket(
      {required Ticket ticket,
      required Function(
              {required String message, required ProcessStatus status})
          onPressed});

  Future<void> updateBookTicket({required Ticket ticket});

  Future<List<Ticket>?> getTickets();
}
