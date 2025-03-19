import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';
import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';
import 'package:vinemas_v1/features/ticket/domain/extension/ticket_status_extension.dart';

class TicketModel extends Ticket {
  TicketModel({
    required super.ticketId,
    required super.sessionId,
    required super.seats,
    required super.totalPrice,
    required super.bookedTime,
    required super.updateTime,
    required super.status,
    required super.content,
  });

  /// Copy ticket with updated values
  TicketModel copyWith({
    String? ticketId,
    String? sessionId,
    List<String>? seats,
    int? totalPrice,
    DateTime? bookedTime,
    DateTime? updateTime,
    TicketStatus? status,
    String? content,
  }) {
    return TicketModel(
      ticketId: ticketId ?? this.ticketId,
      sessionId: sessionId ?? this.sessionId,
      seats: seats ?? this.seats,
      totalPrice: totalPrice ?? this.totalPrice,
      bookedTime: bookedTime ?? this.bookedTime,
      updateTime: updateTime ?? this.updateTime,
      status: status ?? this.status,
      content: content ?? this.content,
    );
  }

  /// Convert entity to model
  factory TicketModel.fromEntity(Ticket ticket) {
    return TicketModel(
      ticketId: ticket.ticketId,
      sessionId: ticket.sessionId,
      seats: ticket.seats,
      totalPrice: ticket.totalPrice,
      bookedTime: ticket.bookedTime,
      updateTime: ticket.updateTime,
      status: ticket.status,
      content: ticket.content,
    );
  }

  /// Convert JSON to TicketModel
  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketId: json['ticketId'] ?? '',
      sessionId: json['sessionMovieId'] ?? '',
      seats: (json['seatInfo'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      totalPrice: json['total'] ?? 0,
      bookedTime: (json['bookingTime'] as Timestamp).toDate(),
      updateTime: json['updateTime'] != null
          ? (json['updateTime'] as Timestamp).toDate()
          : DateTime.now(),
      status: TicketStatusExtension.fromInt(json['status'] ?? 1),
      content: json['content'] ?? '',
    );
  }

  /// Convert TicketModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'sessionMovieId': sessionId,
      'seatInfo': seats,
      'total': totalPrice,
      'bookingTime': Timestamp.fromDate(bookedTime),
      'updateTime': Timestamp.fromDate(updateTime),
      'status': status.toInt(),
      'content': content,
    };
  }
}
