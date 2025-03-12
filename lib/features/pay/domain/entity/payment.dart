import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';

abstract class Payment {
  final String paymentId;
  final String userAuthId;
  final PayMethodEnum paymentMethod;
  final PayStatusEnum paymentStatus;
  final DateTime createdAt; // Thêm thời gian tạo giao dịch

  Payment({
    required this.paymentId,
    required this.userAuthId,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
  });
}
