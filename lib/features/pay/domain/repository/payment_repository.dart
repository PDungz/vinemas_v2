import 'package:vinemas_v1/features/pay/domain/entity/payment.dart';
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';

abstract class PaymentRepository {
  Future<Payment> paymentTicket(
      {required int amount,
      required String currency,
      required PayMethodEnum paymentMethod});

  Future<List<Payment?>> getUserPaymentTicket();

  Future<Payment?> getPayment({required String paymentId});
}
