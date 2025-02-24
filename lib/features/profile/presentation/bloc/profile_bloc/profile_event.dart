// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {}

class ProfileInitialEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class ProfileImageEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class ProfileUpdateUserEvent extends ProfileEvent {
  final UserEntity user;
  final File? imageFile;

  ProfileUpdateUserEvent({
    required this.user,
    this.imageFile,
  });

  @override
  List<Object?> get props => [user];

  ProfileUpdateUserEvent copyWith({
    UserEntity? user,
    File? imageFile,
  }) {
    return ProfileUpdateUserEvent(
      user: user ?? this.user,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}
