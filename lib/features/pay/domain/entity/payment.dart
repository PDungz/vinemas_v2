// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';

abstract class Payment {
  final String paymentId;
  final String userAuthId;
  final String ticketId;
  final PayMethodEnum paymentMethod;
  final PayStatusEnum paymentStatus;
  final String content;
  final DateTime updateAt;
  final DateTime createdAt; // Thêm thời gian tạo giao dịch

  Payment({
    required this.paymentId,
    required this.userAuthId,
    required this.ticketId,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.content,
    required this.updateAt,
    required this.createdAt,
  });
}
