// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  void add(send) {}
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserRegisterWithEmailPasswordState extends UserState {
  final ProcessStatus? processStatus;
  final String? message;

  UserRegisterWithEmailPasswordState({
    this.processStatus = ProcessStatus.idle,
    this.message,
  });

  @override
  List<Object?> get props => [
        processStatus,
        message,
      ];

  UserRegisterWithEmailPasswordState copyWith({
    ProcessStatus? processStatus,
    String? message,
  }) {
    return UserRegisterWithEmailPasswordState(
      processStatus: processStatus ?? this.processStatus,
      message: message ?? this.message,
    );
  }
}

class UserLoginWithEmailPasswordState extends UserState {
  final ProcessStatus processStatus;
  final String? message;

  UserLoginWithEmailPasswordState({
    this.processStatus = ProcessStatus.idle,
    this.message,
  });

  @override
  List<Object?> get props => [
        processStatus,
        message,
      ];

  UserLoginWithEmailPasswordState copyWith({
    ProcessStatus? processStatus,
    String? message,
  }) {
    return UserLoginWithEmailPasswordState(
      processStatus: processStatus ?? this.processStatus,
      message: message ?? this.message,
    );
  }
}

// ignore: camel_case_types
class loginWithThirdPartyState extends UserState {
  final ProcessStatus processStatus;
  final String? message;

  loginWithThirdPartyState({
    this.processStatus = ProcessStatus.idle,
    this.message,
  });

  @override
  List<Object?> get props => [processStatus, message];

  loginWithThirdPartyState copyWith({
    ProcessStatus? processStatus,
    String? message,
  }) {
    return loginWithThirdPartyState(
      processStatus: processStatus ?? this.processStatus,
      message: message ?? this.message,
    );
  }
}

class SendOtpState extends UserState {
  final ProcessStatus processStatus;
  final String? phoneNumber;
  final String? message;

  SendOtpState({
    this.phoneNumber,
    this.processStatus = ProcessStatus.idle,
    this.message,
  });

  @override
  List<Object?> get props => [phoneNumber];

  SendOtpState copyWith({
    ProcessStatus? processStatus,
    String? phoneNumber,
    String? message,
  }) {
    return SendOtpState(
      processStatus: processStatus ?? this.processStatus,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      message: message ?? this.message,
    );
  }
}

// ignore: camel_case_types
class isUserLoggedInState extends UserState {
  final bool? isUserLoggedIn;
  final ProcessStatus processStatus;

  isUserLoggedInState({
    this.isUserLoggedIn,
    this.processStatus = ProcessStatus.idle,
  });

  @override
  List<Object?> get props => [isUserLoggedIn];

  isUserLoggedInState copyWith({
    bool? isUserLoggedIn,
    ProcessStatus? processStatus,
  }) {
    return isUserLoggedInState(
      isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
      processStatus: processStatus ?? this.processStatus,
    );
  }
}

// ignore: camel_case_types
class logoutState extends UserState {
  final ProcessStatus processStatus;
  final String? message;

  logoutState({
    this.processStatus = ProcessStatus.idle,
    this.message,
  });

  @override
  List<Object?> get props => [
        processStatus,
        message,
      ];

  logoutState copyWith({
    ProcessStatus? processStatus,
    String? message,
  }) {
    return logoutState(
      processStatus: processStatus ?? this.processStatus,
      message: message ?? this.message,
    );
  }
}

// ignore: camel_case_types
class resetPasswordState extends UserState {
  final ProcessStatus processStatus;
  final String? message;

  resetPasswordState({
    this.processStatus = ProcessStatus.idle,
    this.message,
  });

  @override
  List<Object?> get props => [
        processStatus,
        message,
      ];

  resetPasswordState copyWith({
    ProcessStatus? processStatus,
    String? message,
  }) {
    return resetPasswordState(
      processStatus: processStatus ?? this.processStatus,
      message: message ?? this.message,
    );
  }
}
