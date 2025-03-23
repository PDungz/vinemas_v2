import 'dart:io';

import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/features/login/domain/entity/user.dart';

// Abstract class that defines the contract for user-related operations.
abstract class UserRepository {
  /// Registers a new user using email and password.
  Future<void> registerWithEmailPassword({
    required UserEntity user,
    required String email,
    required String password,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  /// Logs in a user using [email] and [password].
  Future<void> loginWithEmailPassword({
    required String email,
    required String password,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  /// Logs in a user using Google authentication.
  Future<void> loginWithGoogle({
    required UserEntity user,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  /// Logs in a user using Facebook authentication.
  Future<void> loginWithFacebook({
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  /// Creates user information in the database.
  Future<void> createUserInfo({
    required String userId,
    required UserEntity user,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  /// get user information in the database.
  Future<void> getUserInfo({
    required void Function(
            {required UserEntity? user,
            required String message,
            required ProcessStatus status})
        onPressed,
  });

  /// Updates user information in the database.
  Future<void> updateUserInfo({
    required UserEntity user,
    required File? imageFile,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  /// Sends an OTP code to the given [phoneNumber].
  Future<void> sendCodeOTP({
    required String phoneNumber,
    required String verificationId,
    required void Function({
      required String message,
      required ProcessStatus status,
    }) onPressed,
  });

  /// Verifies the provided OTP code.
  Future<void> verifyCodeOTP({
    required String sendCodeOTP,
    required String verificationId,
    required void Function({
      required String message,
      required ProcessStatus status,
    }) onPressed,
  });

  /// Logs in a user using their [phoneNumber] and [password].
  Future<void> loginWithPhoneNumber({
    required String phoneNumber,
    required String password,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  /// Sends a password reset email to the provided [email].
  Future<void> resetPassword({
    required String email,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  /// Logs out the currently authenticated user.
  Future<void> logout({
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  /// Checks if a user is currently logged in.
  Future<bool> isUserLoggedIn();

  /// Uploads an image to Firebase Storage and returns the image URL.
  Future<String?> uploadImage({
    required File? imageFile,
    required String storagePath,
    required String userId,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });
}
