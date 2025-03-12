import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';
import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';
import 'package:vinemas_v1/features/ticket/domain/extension/ticket_status_extension.dart';

class TicketModel extends Ticket {
  TicketModel(
      {required super.ticketId,
      required super.paymentId,
      required super.sessionId,
      required super.seats,
      required super.totalPrice,
      required super.bookedAt,
      required super.status});

  TicketModel copyWith({
    String? ticketId,
    String? paymentId,
    String? sessionId,
    List<String>? seats,
    int? totalPrice,
    DateTime? bookedAt,
    TicketStatus? status,
  }) {
    return TicketModel(
      ticketId: ticketId ?? this.ticketId,
      paymentId: paymentId ?? this.paymentId,
      sessionId: sessionId ?? this.sessionId,
      seats: seats ?? this.seats,
      totalPrice: totalPrice ?? this.totalPrice,
      bookedAt: bookedAt ?? this.bookedAt,
      status: status ?? this.status,
    );
  }

  factory TicketModel.fromEntity(Ticket ticket) {
    return TicketModel(
        ticketId: ticket.ticketId,
        paymentId: ticket.paymentId,
        sessionId: ticket.sessionId,
        seats: ticket.seats,
        totalPrice: ticket.totalPrice,
        bookedAt: ticket.bookedAt,
        status: ticket.status);
  }

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketId: json['ticketId'],
      paymentId: json['paymentId'],
      sessionId: json['sessionMovieId'],
      seats: List<String>.from(json['seatInfo']),
      totalPrice: json['total'],
      bookedAt: (json['bookingTime'] as Timestamp).toDate(),
      status: TicketStatusExtension.fromInt(json['status'] ?? 1),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'ticketId': ticketId,
      'paymentId': paymentId,
      'sessionMovieId': sessionId,
      'seatInfo': seats,
      'total': totalPrice,
      'bookingTime': Timestamp.now(),
      'status': status.toInt(),
    };
  }
}
