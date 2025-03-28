// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/features/login/domain/entity/user.dart';
import 'package:vinemas_v1/features/login/domain/repository/user_repository.dart';

class UserUseCase {
  final UserRepository userRepository;

  UserUseCase({
    required this.userRepository,
  });

  Future<void> registerWithEmailPassword({
    required UserEntity user,
    required String email,
    required String password,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    return await userRepository.registerWithEmailPassword(
        user: user, email: email, password: password, onPressed: onPressed);
  }

  Future<void> loginWithEmailPassword(
      {required String email,
      required String password,
      required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) async {
    return await userRepository.loginWithEmailPassword(
        email: email, password: password, onPressed: onPressed);
  }

  /// Sends a password reset email to the provided [email].
  Future<void> resetPassword({
    required String email,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    return await userRepository.resetPassword(
        email: email, onPressed: onPressed);
  }

  /// Logs in a user using Google authentication.
  Future<void> loginWithGoogle({
    required UserEntity user,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    return await userRepository.loginWithGoogle(
        user: user, onPressed: onPressed);
  }

  /// Logs in a user using Facebook authentication.
  Future<void> loginWithFacebook(
      {required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) async {
    return await userRepository.loginWithFacebook(onPressed: onPressed);
  }

  Future<void> createUserInfo(
      {required String userId,
      required UserEntity user,
      required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) async {
    return await userRepository.createUserInfo(
        userId: userId, user: user, onPressed: onPressed);
  }

  Future<void> sendCodeOTP({
    required String phoneNumber,
    required String verificationId,
    required void Function({
      required String message,
      required ProcessStatus status,
    }) onPressed,
  }) async {
    return await userRepository.sendCodeOTP(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        onPressed: onPressed);
  }

  Future<void> verifyCodeOTP({
    required String sendCodeOTP,
    required String verificationId,
    required Function Function({
      required String message,
      required ProcessStatus status,
    }) onPressed,
  }) async {
    return await userRepository.verifyCodeOTP(
        sendCodeOTP: sendCodeOTP,
        verificationId: verificationId,
        onPressed: onPressed);
  }

  Future<bool> isUserLoggedIn() async {
    return await userRepository.isUserLoggedIn();
  }

  Future<void> logout(
      {required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) async {
    return await userRepository.logout(onPressed: onPressed);
  }

  Future<void> updateUserInfo(
      {required UserEntity user,
      required File? imageFile,
      required void Function(
              {required String message, required ProcessStatus status})
          onPressed}) async {
    return await userRepository.updateUserInfo(
        user: user, imageFile: imageFile, onPressed: onPressed);
  }

  Future<String?> uploadImage({
    required File? imageFile,
    required String storagePath,
    required String userId,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    return await userRepository.uploadImage(
        imageFile: imageFile,
        storagePath: storagePath,
        userId: userId,
        onPressed: onPressed);
  }

  /// get user information in the database.
  Future<void> getUserInfo({
    required void Function(
            {required UserEntity? user,
            required String message,
            required ProcessStatus status})
        onPressed,
  }) async {
    return await userRepository.getUserInfo(onPressed: onPressed);
  }
}
