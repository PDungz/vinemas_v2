// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:vinemas_v1/core/config/app_url.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/pay/data/model/payment_model.dart';
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';

abstract class PaymentRemoteDataSource {
  Future<PaymentModel> paymentTicket({
    required int amount,
    required String currency,
    required PayMethodEnum paymentMethod,
  });

  Future<PaymentModel?> getPayment({required String paymentId});

  Future<List<PaymentModel?>> getUserPaymentTicket();
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppUrl.urlPay,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Authorization': 'Bearer ${AppUrl.secretKey}',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
  ));

  @override
  Future<PaymentModel> paymentTicket({
    required int amount,
    required String currency,
    required PayMethodEnum paymentMethod,
  }) async {
    try {
      final response = await _dio.post(
        AppUrl.urlPay,
        data: {
          "amount": amount,
          "currency": currency,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer ${AppUrl.secretKey}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.data == null || response.data['client_secret'] == null) {
        printE("Payment failed: Invalid response from server.");
        throw Exception("Invalid response from payment server.");
      }

      final String clientSecret = response.data['client_secret'];

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Vinemas',
        ),
      );
      await Stripe.instance.presentPaymentSheet();

      // Lấy thông tin user
      final String userAuthId = _auth.currentUser?.uid ?? '';
      if (userAuthId.isEmpty) {
        printE("Error: User not authenticated.");
        throw Exception("User authentication failed.");
      }

      // Tạo bill thanh toán sau khi hoàn tất
      PaymentModel paymentModel = PaymentModel(
        paymentId: '', // Firebase sẽ cập nhật ID sau
        userAuthId: userAuthId,
        paymentMethod: paymentMethod,
        paymentStatus: PayStatusEnum.completed,
        createdAt: Timestamp.now().toDate(),
      );

      // Lưu vào Firestore và lấy Document ID
      DocumentReference docRef =
          await _firestore.collection('payment').add(paymentModel.toMap());

      // Cập nhật ID vào model
      PaymentModel savedPayment = paymentModel.copyWith(paymentId: docRef.id);

      // Cập nhật Firestore với ID mới
      await docRef.update({'paymentId': docRef.id});

      printS(
          "Payment successful and saved to Firestore: ${savedPayment.paymentId}");

      return savedPayment; // Trả về đối tượng PaymentModel đã được lưu
    } catch (e) {
      printE("Unexpected Error: $e");
      throw Exception("Unexpected payment error: $e");
    }
  }

  @override
  Future<PaymentModel?> getPayment({required String paymentId}) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('payment').doc(paymentId).get();

      PaymentModel payment =
          PaymentModel.fromJson(snapshot.data() as Map<String, dynamic>);

      printS("Retrieved $payment payment records from Firestore.");
      return payment;
    } catch (e) {
      printE("Error fetching payment tickets: $e");
      throw Exception("Failed to fetch payment tickets.");
    }
  }

  @override
  Future<List<PaymentModel>> getUserPaymentTicket() async {
    try {
      final String userAuthId = _auth.currentUser?.uid ?? '';
      if (userAuthId.isEmpty) {
        printE("Error: User not authenticated.");
        return [];
      }

      QuerySnapshot snapshot = await _firestore
          .collection('payment')
          .where('userAuthId', isEqualTo: userAuthId)
          .get();

      if (snapshot.docs.isEmpty) {
        printE("No payment records found for user $userAuthId.");
        return [];
      }

      List<PaymentModel> payments = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['paymentId'] = doc.id; // Gán document ID vào paymentId
        return PaymentModel.fromJson(data);
      }).toList();

      printS("Retrieved ${payments.length} payments for user: $userAuthId");
      return payments;
    } catch (e) {
      printE("Error fetching user's payment tickets: $e");
      return [];
    }
  }
}
