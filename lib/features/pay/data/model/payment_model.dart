import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vinemas_v1/features/pay/domain/entity/payment.dart';
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';
import 'package:vinemas_v1/features/pay/domain/extension/pay_extension.dart';

class PaymentModel extends Payment {
  PaymentModel(
      {required super.paymentId,
      required super.userAuthId,
      required super.paymentMethod,
      required super.paymentStatus,
      required super.createdAt});

  PaymentModel copyWith({
    String? paymentId,
    String? userAuthId,
    String? ticketId,
    PayMethodEnum? paymentMethod,
    PayStatusEnum? paymentStatus,
    DateTime? createdAt,
  }) {
    return PaymentModel(
      paymentId: paymentId ?? this.paymentId,
      userAuthId: userAuthId ?? this.userAuthId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'paymentId': paymentId,
      'userAuthId': userAuthId,
      'paymentMethod': paymentMethod.toInt(), // Lưu số
      'paymentStatus': paymentStatus.toInt(), // Lưu số
      'createdAt': Timestamp.now(),
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentId: json['paymentId'] as String,
      userAuthId: json['userAuthId'] as String,
      paymentMethod: PayMethodExtension.fromInt(json['paymentMethod'] as int),
      paymentStatus:
          PayStatusEnumExtension.fromInt(json['paymentStatus'] as int),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }
}
