import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';

class Ticket {
  final String id;
  final String userId;
  final String sessionId;
  final List<String> seats;
  final int totalPrice;
  final DateTime bookedAt;
  final TicketStatus status;

  Ticket({
    required this.id,
    required this.userId,
    required this.sessionId,
    required this.seats,
    required this.totalPrice,
    required this.bookedAt,
    required this.status,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['ticketId'],
      userId: json['userAuthId'],
      sessionId: json['sessionMovieId'],
      seats: List<String>.from(json['seatInfo']),
      totalPrice: json['total'],
      bookedAt: DateTime.parse(json['bookingTime']),
      status: TicketStatus.values.firstWhere(
          (e) => e.toString().split('.').last == json['status'],
          orElse: () => TicketStatus.pending),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': id,
      'userAuthId': userId,
      'sessionMovieId': sessionId,
      'seatInfo': seats,
      'total': totalPrice,
      'bookingTime': bookedAt.toIso8601String(),
      'status': status.toString().split('.').last,
    };
  }
}
