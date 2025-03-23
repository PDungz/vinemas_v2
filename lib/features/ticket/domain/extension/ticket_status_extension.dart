import 'package:flutter/material.dart';
import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';

extension TicketStatusExtension on TicketStatus {
  int toInt() {
    switch (this) {
      case TicketStatus.active:
        return 0;
      case TicketStatus.pending:
        return 1;
      case TicketStatus.cancelled:
        return 2;
      case TicketStatus.used:
        return 3;
      case TicketStatus.expired:
        return 4;
    }
  }

  static TicketStatus fromInt(int value) {
    switch (value) {
      case 0:
        return TicketStatus.active;
      case 1:
        return TicketStatus.pending;
      case 2:
        return TicketStatus.cancelled;
      case 3:
        return TicketStatus.used;
      case 4:
        return TicketStatus.expired;
      default:
        throw ArgumentError('Invalid TicketStatus value: $value');
    }
  }

  Color toColor() {
    switch (this) {
      case TicketStatus.active:
        return Colors.green; // Trạng thái có hiệu lực
      case TicketStatus.pending:
        return Colors.orange; // Đang chờ xử lý
      case TicketStatus.cancelled:
        return Colors.red; // Đã hủy
      case TicketStatus.used:
        return Colors.blue; // Đã sử dụng
      case TicketStatus.expired:
        return Colors.grey; // Hết hạn
    }
  }
}
