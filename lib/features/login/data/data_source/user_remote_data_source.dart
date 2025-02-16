import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  /// Logs in a user using Google authentication.
  Future<void> loginWithGoogle({
    required UserModel user,
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

  /// Logs in a user using Facebook authentication.
  Future<void> loginWithFacebook({
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

  /// Checks if a user is currently logged in.
  Future<bool> isUserLoggedIn();

  /// Logs out the currently authenticated user.
  Future<void> logout({
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

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
  Future<void> loginWithGoogle({
    required UserModel user,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        onPressed(
          message: "Google Sign-In was canceled.",
          status: ProcessStatus.failure,
        );
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        final String userId = userCredential.user!.uid;
        final String email = userCredential.user!.email ?? '';

        // Cập nhật email vào model user
        String fullName = 'user${DateTime.now()}';
        user = user.copyWith(fullName: fullName, email: email);

        // Lưu thông tin user vào Firestore
        await createUserInfo(
          userId: userId,
          user: user,
          onPressed: onPressed,
        );

        onPressed(
          message: "Google login successful",
          status: ProcessStatus.success,
        );
        printS("Google login successful - Remote Data Source Impl");
      }
    } on FirebaseAuthException catch (e) {
      onPressed(
        message: e.message ?? "Google login failed",
        status: ProcessStatus.failure,
      );
      printE("Google login failed - Remote Data Source Impl: ${e.message}");
    } catch (e) {
      onPressed(
        message: "An unexpected error occurred",
        status: ProcessStatus.failure,
      );
      printE("An unexpected error occurred - Google login: $e");
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

  @override
  Future<void> loginWithEmailPassword({
    required String email,
    required String password,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    try {
      // Thực hiện đăng nhập với email và mật khẩu
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        onPressed(
          message: "Login successful",
          status: ProcessStatus.success,
        );
        printS(
            'User logged in successfully - loginWithEmailPassword Remote Data Source Impl');
      } else {
        onPressed(
          message: "Login failed. Please try again.",
          status: ProcessStatus.failure,
        );
        printE('Login failed - Remote Data Source Impl');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password provided for that user.";
      }
      onPressed(
        message: errorMessage,
        status: ProcessStatus.failure,
      );
      printE(
          'loginWithEmailPassword failed - Remote Data Source Impl: ${e.message}');
    } catch (e) {
      onPressed(
        message: "An unexpected error occurred",
        status: ProcessStatus.failure,
      );
      printE(
          'An unexpected error occurred - loginWithEmailPassword Remote Data Source Impl: $e');
    }
  }

  @override
  Future<void> loginWithFacebook({
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    try {
      final LoginResult result =
          await _facebookAuth.login(permissions: ['public_profile', 'email']);

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          final String userId = userCredential.user!.uid;
          // Cập nhật email vào model user
          String fullName = 'user${DateTime.now()}';

          // Tạo user model
          UserModel user = UserModel(
            fullName: fullName,
            email: userCredential.user!.email ?? '',
            avatarUrl: userCredential.user!.photoURL ?? '',
          );

          // Lưu thông tin user vào Firestore
          await createUserInfo(
            userId: userId,
            user: user,
            onPressed: onPressed,
          );

          onPressed(
            message: "Facebook login successful",
            status: ProcessStatus.success,
          );
          printS("Facebook login successful - Remote Data Source Impl");
        }
      } else {
        onPressed(
          message: "Facebook login failed: ${result.message}",
          status: ProcessStatus.failure,
        );
        printE(
            "Facebook login failed - Remote Data Source Impl: ${result.message}");
      }
    } on FirebaseAuthException catch (e) {
      onPressed(
        message: e.message ?? "Facebook login failed",
        status: ProcessStatus.failure,
      );
      printE("Facebook login failed - Remote Data Source Impl: ${e.message}");
    } catch (e) {
      onPressed(
        message: "An unexpected error occurred",
        status: ProcessStatus.failure,
      );
      printE("An unexpected error occurred - Facebook login: $e");
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    User? user = _auth.currentUser;
    return user != null;
  }

  @override
  Future<void> logout({
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    try {
      // Đăng xuất khỏi Google (nếu đang dùng Google Sign-In)
      await _googleSignIn.signOut();

      // Đăng xuất khỏi Facebook (nếu đang dùng Facebook Sign-In)
      await _facebookAuth.logOut();

      // Đăng xuất khỏi Firebase (nếu đang dùng Firebase)
      await _auth.signOut();

      onPressed(
        message: "Logout successful",
        status: ProcessStatus.success,
      );
      printS('User logged out successfully - Remote Data Source Impl');
    } catch (e) {
      onPressed(
        message: "Logout failed",
        status: ProcessStatus.failure,
      );
      printE('Logout failed - Remote Data Source Impl: $e');
    }
  }
}
