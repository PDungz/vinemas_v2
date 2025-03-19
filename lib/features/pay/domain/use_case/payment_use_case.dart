// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/pay/domain/entity/payment.dart';
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';
import 'package:vinemas_v1/features/pay/domain/repository/payment_repository.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';

class PaymentUseCase {
  final PaymentRepository paymentRepository;

  PaymentUseCase({
    required this.paymentRepository,
  });

  Future<Payment> paymentTicket({
    required int amount,
    required String currency,
    required PayMethodEnum paymentMethod,
    required Ticket ticket,
  }) async {
    return await paymentRepository.paymentTicket(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
        ticket: ticket);
  }

  Future<List<Payment?>> getUserPaymentTicket() async {
    return await paymentRepository.getUserPaymentTicket();
  }

  Future<Payment?> getPayment({required String paymentId}) async {
    return await paymentRepository.getPayment(paymentId: paymentId);
  }
}
