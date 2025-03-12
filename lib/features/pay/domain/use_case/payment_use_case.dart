// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/pay/domain/entity/payment.dart';
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';
import 'package:vinemas_v1/features/pay/domain/repository/payment_repository.dart';

class PaymentUseCase {
  final PaymentRepository paymentRepository;

  PaymentUseCase({
    required this.paymentRepository,
  });

  Future<Payment> paymentTicket({
    required int amount,
    required String currency,
    required PayMethodEnum paymentMethod,
  }) async {
    return await paymentRepository.paymentTicket(
        amount: amount, currency: currency, paymentMethod: paymentMethod);
  }

  Future<List<Payment?>> getUserPaymentTicket() async {
    return await paymentRepository.getUserPaymentTicket();
  }
}
