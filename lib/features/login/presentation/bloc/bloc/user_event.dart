// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {}

class UserInitialEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class UserRegisterWithEmailPasswordEvent extends UserEvent {
  final String email;
  final String password;
  final UserEntity user;

  UserRegisterWithEmailPasswordEvent({
    required this.email,
    required this.password,
    required this.user,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        user,
      ];

  UserRegisterWithEmailPasswordEvent copyWith({
    String? email,
    String? password,
    UserEntity? user,
  }) {
    return UserRegisterWithEmailPasswordEvent(
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user,
    );
  }
}

// ignore: camel_case_types
class loginWithThirdPartyEvent extends UserEvent {
  final String method;
  final UserEntity user;

  loginWithThirdPartyEvent({
    required this.method,
    required this.user,
  });

  @override
  List<Object?> get props => [method, user];

  loginWithThirdPartyEvent copyWith({
    String? method,
    UserEntity? user,
  }) {
    return loginWithThirdPartyEvent(
      method: method ?? this.method,
      user: user ?? this.user,
    );
  }
}

class UserLoginWithEmailPasswordEvent extends UserEvent {
  final String email;
  final String password;

  UserLoginWithEmailPasswordEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];

  UserLoginWithEmailPasswordEvent copyWith({
    String? email,
    String? password,
  }) {
    return UserLoginWithEmailPasswordEvent(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

// ignore: camel_case_types
class resetPasswordEvent extends UserEvent {
  final String email;

  resetPasswordEvent({
    required this.email,
  });

  @override
  List<Object?> get props => [
        email,
      ];

  resetPasswordEvent copyWith({
    String? email,
  }) {
    return resetPasswordEvent(
      email: email ?? this.email,
    );
  }
}

class SendOtpEvent extends UserEvent {
  final String phoneNumber;
  SendOtpEvent({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber];

  SendOtpEvent copyWith({
    String? phoneNumber,
  }) {
    return SendOtpEvent(
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

// ignore: camel_case_types
class isUserLoggedInEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

// ignore: camel_case_types
class logoutEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}
