// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/pay/data/data_source/payment_remote_data_source.dart';
import 'package:vinemas_v1/features/pay/domain/entity/payment.dart';
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';
import 'package:vinemas_v1/features/pay/domain/repository/payment_repository.dart';

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
  }) async {
    return paymentRemoteDataSource.paymentTicket(
        amount: amount, currency: currency, paymentMethod: paymentMethod);
  }

  @override
  Future<List<Payment?>> getUserPaymentTicket() async {
    return await paymentRemoteDataSource.getUserPaymentTicket();
  }
}
