import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/features/login/domain/entity/user.dart';
import 'package:vinemas_v1/features/login/domain/use_case/user_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileImageEvent>(_onProfileImagePicked);
    on<ProfileUpdateUserEvent>(_onProfileUpdateUserInfo);
    on<ProfileInitialEvent>(_onProfileGetUserInfo);
  }

  Future<void> _onProfileGetUserInfo(
      ProfileInitialEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileGetUserState(
      status: ProcessStatus.loading,
      message: "Getting user info",
    ));
    try {
      await getIt<UserUseCase>().getUserInfo(
        onPressed: (
            {required UserEntity? user,
            required String message,
            required ProcessStatus status}) {
          emit((state as ProfileGetUserState).copyWith(
            user: user,
            status: status,
            message: message,
          ));
        },
      );
    } catch (e) {
      emit(ProfileGetUserState(
        status: ProcessStatus.failure,
        message: "Failed to get user info",
      ));
    }
  }

  Future<void> _onProfileUpdateUserInfo(
      ProfileUpdateUserEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateUserState(
      status: ProcessStatus.loading,
      message: "Updating user info",
    ));
    try {
      await getIt<UserUseCase>().updateUserInfo(
        user: event.user,
        imageFile: event.imageFile,
        onPressed: ({required message, required status}) {
          emit((state as ProfileUpdateUserState).copyWith(
            status: status,
            message: message,
          ));
        },
      );
    } catch (e) {
      emit(ProfileUpdateUserState(
        status: ProcessStatus.failure,
        message: "Failed to update user info",
      ));
    }
  }

  Future<void> _onProfileImagePicked(
      ProfileImageEvent event, Emitter<ProfileState> emit) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (state is ProfileUpdateUserState) {
          emit((state as ProfileUpdateUserState).copyWithImageFile(
            imageFile: File(pickedFile.path),
          ));
        } else {
          emit(ProfileUpdateUserState(
            imageFile: File(pickedFile.path),
            message: "Image selected",
          ));
        }
      }
    } catch (e) {
      emit(ProfileUpdateUserState(
        message: "Failed to pick image",
      ));
    }
  }
}
