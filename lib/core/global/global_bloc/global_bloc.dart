// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vinemas_v1/core/common/enum/status_state.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/entity/configuration.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/usecase/configuration_usecase.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/usecase/shared_preference_usecase.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final ConfigurationUseCase _configurationUseCase =
      getIt<ConfigurationUseCase>();
  final SharedPreferenceUseCase _sharedPreferenceUseCase =
      getIt<SharedPreferenceUseCase>();
  GlobalBloc(
      // this._configurationUseCase,
      // this._sharedPreferenceUseCase,
      )
      : super(GlobalState()) {
    on<GlobalInitEvent>((event, emit) async {
      try {
        emit(state.copyWith(state: StatusState.loading));
        final Configuration? configuration =
            await _configurationUseCase.getConfiguration();
        final Locale? locale =
            await _sharedPreferenceUseCase.getData('language');
        emit(state.copyWith(
          state: StatusState.success,
          configuration: configuration,
          locale: locale,
        ));
      } catch (e) {
        printE("[GlobalBloc] error: $e");
        emit(state.copyWith(
          state: StatusState.failure,
          errorMsg: e.toString(),
        ));
      } finally {
        emit(state.copyWith(state: StatusState.idle));
      }
    });
  }
}
