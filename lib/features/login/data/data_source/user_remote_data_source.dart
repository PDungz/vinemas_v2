import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/login/data/model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> registerWithEmailPassword({
    required UserModel user,
    required String email,
    required String password,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  Future<void> createUserInfo({
    required String userId,
    required UserModel user,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  Future<String?> uploadProfileImage({
    required File imageFile,
    required String storagePath,
    required String userId,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<void> registerWithEmailPassword({
    required UserModel user,
    required String email,
    required String password,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    try {
      // Kiểm tra tài khoản đã tồn tại chưa
      List<String> signInMethods =
          // ignore: deprecated_member_use
          await _auth.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        onPressed(
          message: "Email has already been registered.",
          status: ProcessStatus.failure,
        );
        printE('Email already exists - Remote Data Source Impl');
        return;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Tạo thông tin user ngay sau khi đăng ký thành công
        await createUserInfo(
          userId: userCredential.user!.uid,
          user: user,
          onPressed: onPressed,
        );

        onPressed(
          message: "User registered successfully",
          status: ProcessStatus.success,
        );
        printS('User registered successfully - Remote Data Source Impl');
      }
    } on FirebaseAuthException catch (e) {
      onPressed(
        message: e.message ?? "Registration failed",
        status: ProcessStatus.failure,
      );
      printE('Registration failed - Remote Data Source Impl: ${e.message}');
      return;
    } catch (e) {
      onPressed(
        message: "An unexpected error occurred",
        status: ProcessStatus.failure,
      );
      printE('An unexpected error occurred  - Remote Data Source Impl: $e');
      return;
    }
  }

  @override
  Future<void> createUserInfo({
    required String userId,
    required UserModel user,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    try {
      // Kiểm tra xem thông tin user đã tồn tại chưa
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        onPressed(
          message: "User info already exists",
          status: ProcessStatus.failure,
        );
        printE('User info already exists - Remote Data Source Impl');
        return;
      }

      // Lưu thông tin nếu chưa tồn tại
      await _firestore.collection('users').doc(userId).set(user.toMap());
      onPressed(
        message: "User info saved successfully",
        status: ProcessStatus.success,
      );
      printS('User info saved successfully - Remote Data Source Impl');
    } catch (e) {
      onPressed(
        message: "Failed to save user info",
        status: ProcessStatus.failure,
      );
      printE('Failed to save user info - Remote Data Source Impl: $e');
    }
  }

  @override
  Future<String?> uploadProfileImage({
    required File imageFile,
    required String storagePath,
    required String userId,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    try {
      String filePath =
          '$storagePath/$userId/${DateTime.now().millisecondsSinceEpoch}';
      // Create URL in Firebase Storage
      Reference storageReference = _storage.ref().child(filePath);

      // Upload image to Firebase Storage
      await storageReference.putFile(imageFile);

      // Get download URL
      String downloadUrl = await storageReference.getDownloadURL();
      onPressed(
        message: "Profile image uploaded successfully",
        status: ProcessStatus.success,
      );
      printS(
          'Profile image uploaded successfully - Remote Data Source Impl: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      onPressed(
        message: "Failed to upload profile image",
        status: ProcessStatus.failure,
      );
      printE('Failed to upload profile image - Remote Data Source Impl: $e');
      return null;
    }
  }
}
