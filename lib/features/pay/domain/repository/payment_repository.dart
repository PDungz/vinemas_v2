import 'package:vinemas_v1/features/pay/domain/entity/payment.dart';
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';

abstract class PaymentRepository {
  Future<Payment> paymentTicket({
    required int amount,
    required String currency,
    required PayMethodEnum paymentMethod,
    required Ticket ticket,
  });

  Future<List<Payment?>> getUserPaymentTicket();

  Future<Payment?> getPayment({required String paymentId});
}
