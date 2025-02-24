// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/gender.dart';

class UserEntity extends Equatable {
  final String? avatarUrl;
  final String? fullName;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String email;
  final Gender? gender;
  final String? address;

  const UserEntity({
    this.avatarUrl,
    this.fullName,
    this.dateOfBirth,
    this.phoneNumber,
    required this.email,
    this.gender,
    this.address,
  });

  @override
  List<Object?> get props => [
        avatarUrl,
        fullName,
        dateOfBirth,
        phoneNumber,
        email,
        gender,
        address,
      ];

  UserEntity copyWith({
    String? avatarUrl,
    String? fullName,
    DateTime? dateOfBirth,
    String? phoneNumber,
    String? email,
    Gender? gender,
    String? address,
  }) {
    return UserEntity(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      address: address ?? this.address,
    );
  }
}
