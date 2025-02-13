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
