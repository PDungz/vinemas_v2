// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileUpdateUserState extends ProfileState {
  final ProcessStatus status;
  final UserEntity? user;
  final File? imageFile;
  final String message;

  ProfileUpdateUserState({
    this.status = ProcessStatus.idle,
    this.user,
    this.imageFile,
    required this.message,
  });

  @override
  List<Object?> get props => [status, user, imageFile, message];

  ProfileUpdateUserState copyWith({
    ProcessStatus? status,
    UserEntity? user,
    File? imageFile,
    String? message,
  }) {
    return ProfileUpdateUserState(
      status: status ?? this.status,
      user: user ?? this.user,
      imageFile: imageFile ?? this.imageFile,
      message: message ?? this.message,
    );
  }

  ProfileUpdateUserState copyWithImageFile({
    ProcessStatus? status,
    UserEntity? user,
    File? imageFile,
    String? message,
  }) {
    return ProfileUpdateUserState(
      status: status ?? this.status,
      user: user ?? this.user,
      imageFile: imageFile,
      message: message ?? this.message,
    );
  }
}

class ProfileGetUserState extends ProfileState {
  final ProcessStatus status;
  final UserEntity? user;
  final String message;

  ProfileGetUserState({
    this.status = ProcessStatus.idle,
    this.user,
    required this.message,
  });

  @override
  List<Object?> get props => [status, user, message];

  ProfileGetUserState copyWith({
    ProcessStatus? status,
    UserEntity? user,
    String? message,
  }) {
    return ProfileGetUserState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }

  ProfileGetUserState copyWithImageFile({
    ProcessStatus? status,
    UserEntity? user,
    String? message,
  }) {
    return ProfileGetUserState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }
}


