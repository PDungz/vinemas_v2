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
  final _userUserCase = getIt<UserUseCase>();
  UserBloc() : super(UserInitial()) {
    on<UserInitialEvent>(
      (event, emit) {},
    );
    on<SendOtpEvent>(sendCodeOTP);
    on<UserRegisterWithEmailPasswordEvent>(registerWithEmailPassword);
    on<UserLoginWithEmailPasswordEvent>(loginWithEmailPassword);
    on<loginWithThirdPartyEvent>(loginWithThirdParty);
    on<isUserLoggedInEvent>(isUserLoggedIn);
    on<logoutEvent>(logout);
  }

  Future<void> registerWithEmailPassword(
      UserRegisterWithEmailPasswordEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserRegisterWithEmailPasswordState(
          processStatus: ProcessStatus.loading));

      await _userUserCase.registerWithEmailPassword(
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

  Future<void> loginWithEmailPassword(
      UserLoginWithEmailPasswordEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoginWithEmailPasswordState(
          processStatus: ProcessStatus.loading));
      await _userUserCase.loginWithEmailPassword(
        email: event.email,
        password: event.password,
        onPressed: ({required message, required status}) {
          emit(UserLoginWithEmailPasswordState(
            message: message,
            processStatus: status,
          ));
        },
      );
    } catch (e) {
      emit(
        UserLoginWithEmailPasswordState(
            message: 'An unexpected error occurred',
            processStatus: ProcessStatus.failure),
      );
    }
  }

  Future<void> loginWithThirdParty(
      loginWithThirdPartyEvent event, Emitter<UserState> emit) async {
    try {
      emit(loginWithThirdPartyState(processStatus: ProcessStatus.loading));

      if (event.method == 'google') {
        await _userUserCase.loginWithGoogle(
          user: User(email: ''),
          onPressed: ({required message, required status}) {
            emit(loginWithThirdPartyState(
              message: message,
              processStatus: status,
            ));
          },
        );
      }
      if (event.method == 'facebook') {
        await _userUserCase.loginWithFacebook(
          onPressed: ({required message, required status}) {
            emit(loginWithThirdPartyState(
              message: message,
              processStatus: status,
            ));
          },
        );
      }
    } catch (e) {
      emit(loginWithThirdPartyState(
        message: '$e',
        processStatus: ProcessStatus.failure,
      ));
    }
  }

  Future<void> sendCodeOTP(SendOtpEvent event, Emitter<UserState> emit) async {
    try {
      emit(SendOtpState(processStatus: ProcessStatus.loading));

      final completer = Completer<void>(); // Tạo Completer để đợi callback

      await _userUserCase.sendCodeOTP(
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

  Future<void> isUserLoggedIn(
      isUserLoggedInEvent event, Emitter<UserState> emit) async {
    try {
      emit(isUserLoggedInState(processStatus: ProcessStatus.loading));
      final isUserLoggedIn = await _userUserCase.isUserLoggedIn();

      emit(isUserLoggedInState(
          isUserLoggedIn: isUserLoggedIn,
          processStatus: ProcessStatus.success));
    } catch (e) {
      emit(isUserLoggedInState(
        isUserLoggedIn: false,
        processStatus: ProcessStatus.success,
      ));
    }
  }

  Future<void> logout(logoutEvent event, Emitter<UserState> emit) async {
    try {
      emit(logoutState(processStatus: ProcessStatus.loading));
      await _userUserCase.logout(
        onPressed: ({required message, required status}) {
          emit(logoutState(processStatus: status, message: message));
        },
      );
    } catch (e) {
      emit(
        logoutState(
          processStatus: ProcessStatus.failure,
          message: '$e',
        ),
      );
    }
  }
}
