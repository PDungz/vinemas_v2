import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinemas_v1/core/api/dio_client.dart';
import 'package:vinemas_v1/core/global/api/configuration/data/datasources/configuration_remote_data_source.dart';
import 'package:vinemas_v1/core/global/api/configuration/data/repository/configuration_repository_impl.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/repository/configuration_repository.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/usecase/configuration_usecase.dart';
import 'package:vinemas_v1/core/global/api/genres/data/datasource/genres_remote_data_source.dart';
import 'package:vinemas_v1/core/global/api/genres/data/repository_impl/genres_repository_impl.dart';
import 'package:vinemas_v1/core/global/api/genres/domain/repository/genres_repository.dart';
import 'package:vinemas_v1/core/global/api/genres/domain/usecase/genres_usecase.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/data/datasource/shared_preference_local_data_source.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/data/repository_impl/shared_preference_repository_impl.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/repository/shared_preference_repository.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/usecase/shared_preference_usecase.dart';
import 'package:vinemas_v1/features/home/data/datasource/now_playing_remote_data_source.dart';
import 'package:vinemas_v1/features/home/data/datasource/upcoming_remote_data_source.dart';
import 'package:vinemas_v1/features/home/data/repository_impl/now_playing_repository_impl.dart';
import 'package:vinemas_v1/features/home/data/repository_impl/upcoming_repository_impl.dart';
import 'package:vinemas_v1/features/home/domain/repository/now_playing_repository.dart';
import 'package:vinemas_v1/features/home/domain/repository/upcoming_repository.dart';
import 'package:vinemas_v1/features/home/domain/usecase/now_playing_usecase.dart';
import 'package:vinemas_v1/features/home/domain/usecase/upcoming_usecase.dart';

final getIt = GetIt.instance;

Future<void> initDI() async {
  //! Shared Preference
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //! Dio Client
  getIt.registerSingleton<DioClient>(DioClient());

  //! Data
  //* Remote Data Source Configuration
  getIt.registerLazySingleton<ConfigurationRemoteDataSource>(
    () => ConfigurationRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
  );

  //* Local Data Source Shared Preference
  getIt.registerLazySingleton<SharedPreferenceLocalDataSource>(
    () => SharedPreferenceLocalDataSourceImpl(
        sharedPreferences: sharedPreferences),
  );

  //* Remote Data Source Genres
  getIt.registerLazySingleton<GenresRemoteDataSource>(
    () => GenresRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
  );

  //* Remote Data Source Upcoming
  getIt.registerLazySingleton<UpcomingRemoteDataSource>(
    () => UpcomingRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
  );

  // * Remote Data Source Now Playing
  getIt.registerLazySingleton<NowPlayingRemoteDataSource>(
    () => NowPlayingRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
  );

  //! Repository
  //* Configuration Repository
  getIt.registerLazySingleton<ConfigurationRepository>(
    () => ConfigurationRepositoryImpl(configurationRemoteDataSource: getIt()),
  );

  //* Shared Preference Repository
  getIt.registerLazySingleton<SharedPreferenceRepository>(
    () => SharedPreferenceRepositoryImpl(
        sharedPreferenceLocalDataSource: getIt()),
  );

  //* Genres Repository
  getIt.registerLazySingleton<GenresRepository>(
    () => GenresRepositoryImpl(genresRemoteDataSource: getIt()),
  );

  //* Upcoming Repository
  getIt.registerLazySingleton<UpcomingRepository>(
    () => UpcomingRepositoryImpl(upcomingRemoteDataSource: getIt()),
  );

  //* Now Playing Repository
  getIt.registerLazySingleton<NowPlayingRepository>(
    () => NowPlayingRepositoryImpl(nowPlayingRemoteDataSource: getIt()),
  );

  //! Use case
  //* Configuration Use Case
  getIt.registerSingleton<ConfigurationUseCase>(
    ConfigurationUseCase(getIt()),
  );

  //* Shared Preference Use Case
  getIt.registerSingleton<SharedPreferenceUseCase>(
    SharedPreferenceUseCase(getIt()),
  );

  //* Genres Use Case
  getIt.registerSingleton<GenresUseCase>(
    GenresUseCase(getIt()),
  );

  //* Upcoming Use Case
  getIt.registerSingleton<UpcomingUseCase>(
    UpcomingUseCase(getIt()),
  );

  //* Now Playing Use Case
  getIt.registerSingleton(
    NowPlayingUseCase(nowPlayingRepository: getIt()),
  );
}
