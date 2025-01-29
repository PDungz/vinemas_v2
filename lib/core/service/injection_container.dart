import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinemas_v1/core/api/dio_client.dart';
import 'package:vinemas_v1/core/global/api/configuration/data/datasources/configuration_remote_data_source.dart';
import 'package:vinemas_v1/core/global/api/configuration/data/repository/configuration_repository_impl.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/repository/configuration_repository.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/usecase/configuration_usecase.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/data/datasource/shared_preference_local_data_source.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/data/repository_impl/shared_preference_repository_impl.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/repository/shared_preference_repository.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/usecase/shared_preference_usecase.dart';

final getIt = GetIt.instance;

Future<void> initDI() async {
  //! Shared Preference
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //! Dio Client
  getIt.registerSingleton<DioClient>(DioClient());

  //! Data
  getIt.registerLazySingleton<ConfigurationRemoteDataSource>(
    () => ConfigurationRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<SharedPreferenceLocalDataSource>(
    () => SharedPreferenceLocalDataSourceImpl(
        sharedPreferences: sharedPreferences),
  );

  //! Repository
  getIt.registerLazySingleton<ConfigurationRepository>(
    () => ConfigurationRepositoryImpl(configurationRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<SharedPreferenceRepository>(
    () => SharedPreferenceRepositoryImpl(
        sharedPreferenceLocalDataSource: getIt()),
  );

  //! Use case
  getIt.registerSingleton<ConfigurationUseCase>(
    ConfigurationUseCase(getIt()),
  );
  getIt.registerSingleton<SharedPreferenceUseCase>(
    SharedPreferenceUseCase(getIt()),
  );
}
