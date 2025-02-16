import 'package:vinemas_v1/core/common/enum/gender.dart';
import 'package:vinemas_v1/core/common/extension/gender_extension.dart';
import 'package:vinemas_v1/features/login/domain/entity/user.dart';

class UserModel extends User {
  const UserModel({
    super.avatarUrl,
    super.fullName,
    super.dateOfBirth,
    super.phoneNumber,
    required super.email,
    super.gender,
    super.address,
  });

  UserModel copyWith({
    String? avatarUrl,
    String? fullName,
    DateTime? dateOfBirth,
    String? phoneNumber,
    String? email,
    Gender? gender,
    String? address,
  }) {
    return UserModel(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatarUrl': avatarUrl ?? '',
      'fullName': fullName ?? '',
      'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch ?? '',
      'phoneNumber': phoneNumber ?? '',
      'email': email,
      'gender': gender?.toInt() ?? 0,
      'address': address ?? '',
    };
  }

  static UserModel fromEntity(User user) {
    return UserModel(
      avatarUrl: user.avatarUrl,
      fullName: user.fullName,
      dateOfBirth: user.dateOfBirth,
      phoneNumber: user.phoneNumber,
      email: user.email,
      gender: user.gender,
      address: user.address,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      avatarUrl: json['avatarUrl'] != null ? json['avatarUrl'] as String : null,
      fullName: json['fullName'] != null ? json['fullName'] as String : null,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['dateOfBirth'] as int)
          : null,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] != null ? json['email'] as String : '',
      gender: GenderExtension.fromInt(json['gender']),
      address: json['address'] != null ? json['address'] as String : null,
    );
  }
}
