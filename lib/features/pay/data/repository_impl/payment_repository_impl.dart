// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/pay/data/data_source/payment_remote_data_source.dart';
import 'package:vinemas_v1/features/pay/domain/entity/payment.dart';
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';
import 'package:vinemas_v1/features/pay/domain/repository/payment_repository.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource paymentRemoteDataSource;

  PaymentRepositoryImpl({
    required this.paymentRemoteDataSource,
  });
  @override
  Future<Payment> paymentTicket({
    required int amount,
    required String currency,
    required PayMethodEnum paymentMethod,
    required Ticket ticket,
  }) async {
    return paymentRemoteDataSource.paymentTicket(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
        ticket: ticket);
  }

  @override
  Future<List<Payment?>> getUserPaymentTicket() async {
    return await paymentRemoteDataSource.getUserPaymentTicket();
  }

  @override
  Future<Payment?> getPayment({required String paymentId}) async {
    return await paymentRemoteDataSource.getPayment(paymentId: paymentId);
  }

  @override
  Future<Payment> refundTicket({
    required int amount,
    required String currency,
    required PayMethodEnum paymentMethod,
    required Ticket ticket,
  }) async {
    return await paymentRemoteDataSource.refundTicket(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
        ticket: ticket);
  }
}
