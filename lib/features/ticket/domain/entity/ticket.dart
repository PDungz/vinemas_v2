import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';

abstract class Ticket {
  final String ticketId;
  final String sessionId;
  final List<String> seats;
  final int totalPrice;
  final DateTime bookedTime;
  final DateTime updateTime;
  final TicketStatus status;
  final String content;

  Ticket({
    required this.ticketId,
    required this.sessionId,
    required this.seats,
    required this.totalPrice,
    required this.bookedTime,
    required this.updateTime,
    required this.status,
    required this.content,
  });
}
