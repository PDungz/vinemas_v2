// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/features/login/domain/entity/user.dart';
import 'package:vinemas_v1/features/login/domain/repository/user_repository.dart';

class UserUseCase {
  final UserRepository userRepository;

  UserUseCase({
    required this.userRepository,
  });

  Future<void> registerWithEmailPassword({
    required User user,
    required String email,
    required String password,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    return await userRepository.registerWithEmailPassword(
        user: user, email: email, password: password, onPressed: onPressed);
  }

  Future<void> createUserInfo(
      {required String userId,
      required User user,
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
}
