// ignore: depend_on_referenced_packages
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/entity/configuration.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/use_case/configuration_use_case.dart';
import 'package:vinemas_v1/core/global/api/genres/domain/entity/genres.dart';
import 'package:vinemas_v1/core/global/api/genres/domain/use_case/genres_use_case.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/use_case/shared_preference_use_case.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState()) {
    on<GlobalInitEvent>((event, emit) async {
      try {
        emit(state.copyWith(state: ProcessStatus.loading));
        String? localeString =
            await getIt<SharedPreferenceUseCase>().getData('language');

        if (localeString == null) {
          localeString ??= PlatformDispatcher.instance.locale.languageCode;
          await getIt<SharedPreferenceUseCase>()
              .saveData('language', localeString);
        }

        bool isVietnamese = localeString.contains('vi') ? true : false;

        final Locale locale = Locale(localeString);

        final Configuration? configuration =
            await getIt<ConfigurationUseCase>().getConfiguration();

        final List<Genres>? genres = await getIt<GenresUseCase>().getGenres();
        emit(state.copyWith(
          isVietnamese: isVietnamese,
          state: ProcessStatus.success,
          configuration: configuration,
          genres: genres,
          locale: locale,
        ));
      } catch (e) {
        printE("[GlobalBloc] error: $e");
        emit(state.copyWith(
          state: ProcessStatus.failure,
          errorMsg: e.toString(),
        ));
      } finally {
        emit(state.copyWith(state: ProcessStatus.idle));
      }
    });

    on<LanguageEvent>(
      (event, emit) async {
        try {
          emit(state.copyWith(state: ProcessStatus.loading));
          String? localeString = event.language;

          await getIt<SharedPreferenceUseCase>()
              .updateData('language', localeString);

          bool isVietnamese = localeString.contains('vi') ? true : false;

          final Locale locale = Locale(localeString);

          final Configuration? configuration =
              await getIt<ConfigurationUseCase>().getConfiguration();

          final List<Genres>? genres = await getIt<GenresUseCase>().getGenres();
          emit(state.copyWith(
            isVietnamese: isVietnamese,
            state: ProcessStatus.success,
            configuration: configuration,
            genres: genres,
            locale: locale,
          ));
        } catch (e) {
          printE("[GlobalBloc] error: $e");
          emit(state.copyWith(
            state: ProcessStatus.failure,
            errorMsg: e.toString(),
          ));
        } finally {
          emit(state.copyWith(state: ProcessStatus.idle));
        }
      },
    );
  }
}
