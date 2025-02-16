// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/features/login/data/data_source/user_remote_data_source.dart';
import 'package:vinemas_v1/features/login/data/model/user_model.dart';
import 'package:vinemas_v1/features/login/domain/entity/user.dart';
import 'package:vinemas_v1/features/login/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
  });

  @override
  Future<void> registerWithEmailPassword({
    required User user,
    required String email,
    required String password,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    return await userRemoteDataSource.registerWithEmailPassword(
        user: UserModel.fromEntity(user),
        email: email,
        password: password,
        onPressed: onPressed);
  }

  @override
  Future<void> loginWithGoogle({
    required User user,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    return await userRemoteDataSource.loginWithGoogle(
        user: UserModel.fromEntity(user), onPressed: onPressed);
  }

  @override
  Future<void> createUserInfo(
      {required String userId,
      required User user,
      required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) async {
    return await userRemoteDataSource.createUserInfo(
        userId: userId, user: UserModel.fromEntity(user), onPressed: onPressed);
  }

  @override
  Future<void> updateUserInfo(
      {required User user,
      required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) {
    // TODO: implement updateUserInfo
    throw UnimplementedError();
  }

  @override
  Future<void> loginWithEmailPassword(
      {required String email,
      required String password,
      required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) async {
    return await userRemoteDataSource.loginWithEmailPassword(
        email: email, password: password, onPressed: onPressed);
  }

  @override
  Future<void> loginWithFacebook(
      {required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) async {
    return await userRemoteDataSource.loginWithFacebook(onPressed: onPressed);
  }

  @override
  Future<void> loginWithPhoneNumber(
      {required String phoneNumber,
      required String password,
      required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) {
    // TODO: implement loginWithPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return await userRemoteDataSource.isUserLoggedIn();
  }

  @override
  Future<void> logout(
      {required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) async {
    return await userRemoteDataSource.logout(onPressed: onPressed);
  }

  @override
  Future<void> resetPassword(
      {required String email,
      required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> sendCodeOTP(
      {required String phoneNumber,
      required String verificationId,
      required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) {
    // TODO: implement sendCodeOTP
    throw UnimplementedError();
  }

  @override
  Future<void> verifyCodeOTP(
      {required String sendCodeOTP,
      required String verificationId,
      required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) {
    // TODO: implement verifyCodeOTP
    throw UnimplementedError();
  }

  @override
  Future<String?> uploadUserImage({
    required File imageFile,
    required String storagePath,
    required String userId,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async =>
      await userRemoteDataSource.uploadProfileImage(
          imageFile: imageFile,
          storagePath: storagePath,
          userId: userId,
          onPressed: onPressed);
}
