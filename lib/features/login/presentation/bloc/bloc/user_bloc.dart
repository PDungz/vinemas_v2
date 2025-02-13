import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/features/login/domain/entity/user.dart';
import 'package:vinemas_v1/features/login/domain/use_case/user_use_case.dart';
import 'dart:async';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserInitialEvent>(
      (event, emit) {},
    );
    on<SendOtpEvent>(sendCodeOTP);
    on<UserRegisterWithEmailPasswordEvent>(registerWithEmailPassword);
  }

  Future<void> registerWithEmailPassword(
      UserRegisterWithEmailPasswordEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserRegisterWithEmailPasswordState(
          processStatus: ProcessStatus.loading));

      await getIt<UserUseCase>().registerWithEmailPassword(
        user: event.user,
        email: event.email,
        password: event.password,
        onPressed: ({required message, required status}) {
          emit(UserRegisterWithEmailPasswordState(
            message: message,
            processStatus: status,
          ));
        },
      );
    } catch (e) {
      emit(UserRegisterWithEmailPasswordState(
          message: 'An unexpected error occurred',
          processStatus: ProcessStatus.failure));
    }
  }

  Future<void> sendCodeOTP(SendOtpEvent event, Emitter<UserState> emit) async {
    try {
      emit(SendOtpState(processStatus: ProcessStatus.loading));

      final completer = Completer<void>(); // Tạo Completer để đợi callback

      await getIt<UserUseCase>().sendCodeOTP(
        phoneNumber: event.phoneNumber,
        verificationId: "",
        onPressed: ({required message, required status}) {
          emit(SendOtpState(
            processStatus: status,
            message: message,
          ));
          completer.complete(); // Đánh dấu rằng callback đã hoàn tất
        },
      );

      await completer.future; // Đợi đến khi callback hoàn tất
    } catch (e) {
      emit(SendOtpState(
        processStatus: ProcessStatus.failure,
        message: "An error occurred: $e",
      ));
    }
  }
}
