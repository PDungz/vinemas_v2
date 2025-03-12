import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/login/data/model/user_model.dart';
import 'package:vinemas_v1/features/login/domain/entity/user.dart';

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

  /// Sends a password reset email to the provided [email].
  Future<void> resetPassword({
    required String email,
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

  /// Updates user information in the database.
  Future<void> updateUserInfo({
    required UserModel user,
    required File? imageFile,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  Future<String?> uploadImage({
    required File? imageFile,
    required String storagePath,
    required String userId,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  });

  /// Get user information in the database.
  Future<void> getUserInfo({
    required void Function({
      required UserEntity? user,
      required String message,
      required ProcessStatus status,
    }) onPressed,
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
  Future<void> resetPassword({
    required String email,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      onPressed(
        message: "Password reset email sent successfully",
        status: ProcessStatus.success,
      );
      printS('Password reset email sent - Remote Data Source Impl');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onPressed(
          message: "No user found for this email",
          status: ProcessStatus.failure,
        );
      } else {
        onPressed(
          message: e.message ?? "Failed to send password reset email",
          status: ProcessStatus.failure,
        );
      }
      printE(
          'Failed to send password reset email - Remote Data Source Impl: ${e.message}');
    } catch (e) {
      onPressed(
        message: "An unexpected error occurred",
        status: ProcessStatus.failure,
      );
      printE(
          'Unexpected error during password reset - Remote Data Source Impl: $e');
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
  Future<String?> uploadImage({
    required File? imageFile,
    required String storagePath,
    required String userId,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    if (imageFile == null) {
      onPressed(
        message: "No image selected",
        status: ProcessStatus.failure,
      );
      printE('No image selected - Remote Data Source Impl');
      return null;
    }

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
  Future<void> updateUserInfo({
    required UserModel user,
    required File? imageFile,
    required void Function(
            {required String message, required ProcessStatus status})
        onPressed,
  }) async {
    try {
      // Lấy thông tin người dùng hiện tại từ Firebase Authentication
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        onPressed(
          message: "User is not logged in",
          status: ProcessStatus.failure,
        );
        printE("User is not logged in - Remote Data Source Impl");
        return;
      }

      String uid = currentUser.uid;

      // Kiểm tra xem người dùng có tồn tại trong Firestore không
      DocumentReference userRef = _firestore.collection('users').doc(uid);
      DocumentSnapshot userDoc = await userRef.get();

      if (!userDoc.exists) {
        onPressed(
          message: "User does not exist",
          status: ProcessStatus.failure,
        );
        printE("User does not exist - Remote Data Source Impl");
        return;
      }

      String urlImageUser = await uploadImage(
              imageFile: imageFile,
              storagePath: 'imageUser',
              userId: uid,
              onPressed: onPressed) ??
          '';
      user = user.copyWith(avatarUrl: urlImageUser);
      // Cập nhật thông tin người dùng
      await userRef.update(user.toMap());

      onPressed(
        message: "User info updated successfully",
        status: ProcessStatus.success,
      );
      printS("User info updated successfully - Remote Data Source Impl");
    } catch (e) {
      onPressed(
        message: "Failed to update user info",
        status: ProcessStatus.failure,
      );
      printE("Failed to update user info - Remote Data Source Impl: $e");
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

  @override
  Future<void> getUserInfo({
    required void Function(
            {required UserEntity? user,
            required String message,
            required ProcessStatus status})
        onPressed,
  }) async {
    try {
      // Lấy user hiện tại từ FirebaseAuth
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        onPressed(
          user: null,
          message: "No logged-in user found",
          status: ProcessStatus.failure,
        );
        printE("No logged-in user found - Remote Data Source Impl");
        return;
      }

      // Truy vấn Firestore để lấy thông tin user
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();

      if (!userDoc.exists) {
        onPressed(
          user: null,
          message: "User info not found in database",
          status: ProcessStatus.failure,
        );
        printE("User info not found - Remote Data Source Impl");
        return;
      }

      // Chuyển đổi dữ liệu Firestore thành UserModel
      UserModel user =
          UserModel.fromJson(userDoc.data() as Map<String, dynamic>);

      onPressed(
        user: UserEntity(
          userId: currentUser.uid,
          avatarUrl: user.avatarUrl,
          fullName: user.fullName,
          dateOfBirth: user.dateOfBirth,
          phoneNumber: user.phoneNumber,
          email: user.email,
          address: user.address,
          gender: user.gender,
        ),
        message: "User info retrieved successfully",
        status: ProcessStatus.success,
      );
      printS("User info retrieved successfully - Remote Data Source Impl");
    } catch (e) {
      onPressed(
        user: null,
        message: "Failed to retrieve user info",
        status: ProcessStatus.failure,
      );
      printE("Failed to retrieve user info - Remote Data Source Impl: $e");
    }
  }
}
