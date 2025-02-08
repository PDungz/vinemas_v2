import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinemas_v1/core/api/dio_client.dart';
import 'package:vinemas_v1/core/global/api/configuration/data/datasources/configuration_remote_data_source.dart';
import 'package:vinemas_v1/core/global/api/configuration/data/repository/configuration_repository_impl.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/repository/configuration_repository.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/use_case/configuration_use_case.dart';
import 'package:vinemas_v1/core/global/api/genres/data/datasource/genres_remote_data_source.dart';
import 'package:vinemas_v1/core/global/api/genres/data/repository_impl/genres_repository_impl.dart';
import 'package:vinemas_v1/core/global/api/genres/domain/repository/genres_repository.dart';
import 'package:vinemas_v1/core/global/api/genres/domain/use_case/genres_use_case.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/data/datasource/shared_preference_local_data_source.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/data/repository_impl/shared_preference_repository_impl.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/repository/shared_preference_repository.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/use_case/shared_preference_use_case.dart';
import 'package:vinemas_v1/features/about_sessions/data/data_source/cast_remote_data_source.dart';
import 'package:vinemas_v1/features/about_sessions/data/data_source/movie_detail_remote_data_source.dart';
import 'package:vinemas_v1/features/about_sessions/data/data_source/video_remote_data_source.dart';
import 'package:vinemas_v1/features/about_sessions/data/repository/cast_repository_impl.dart';
import 'package:vinemas_v1/features/about_sessions/data/repository/movie_detail_repository_impl.dart';
import 'package:vinemas_v1/features/about_sessions/data/repository/video_repository_impl.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/cast_repository.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/movie_detail_repository.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/video_repository.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/cast_use_case.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/movie_detail_use_case.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/video_use_case.dart';
import 'package:vinemas_v1/features/home/data/datasource/now_playing_remote_data_source.dart';
import 'package:vinemas_v1/features/home/data/datasource/upcoming_remote_data_source.dart';
import 'package:vinemas_v1/features/home/data/repository_impl/now_playing_repository_impl.dart';
import 'package:vinemas_v1/features/home/data/repository_impl/upcoming_repository_impl.dart';
import 'package:vinemas_v1/features/home/domain/repository/now_playing_repository.dart';
import 'package:vinemas_v1/features/home/domain/repository/upcoming_repository.dart';
import 'package:vinemas_v1/features/home/domain/use_case/now_playing_use_case.dart';
import 'package:vinemas_v1/features/home/domain/use_case/upcoming_use_case.dart';

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

  // * Remote Data Source Movie Detail
  getIt.registerLazySingleton<MovieDetailRemoteDataSource>(
    () => MovieDetailRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
  );

  // * Remote Data Source Videos
  getIt.registerLazySingleton<VideoRemoteDataSource>(
    () => VideoRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
  );

  // * Remote Data Source Cast
  getIt.registerLazySingleton<CastRemoteDataSource>(
    () => CastRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
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

  //* Movie Detail Repository
  getIt.registerLazySingleton<MovieDetailRepository>(
    () => MovieDetailRepositoryImpl(movieDetailRemoteDataSource: getIt()),
  );

  //* Video Repository
  getIt.registerLazySingleton<VideoRepository>(
    () => VideoRepositoryImpl(videoRemoteDataSource: getIt()),
  );

  //* Cast Repository
  getIt.registerLazySingleton<CastRepository>(
    () => CastRepositoryImpl(castRemoteDataSource: getIt()),
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

  //* Movie Detail Use Case
  getIt.registerSingleton(
    MovieDetailUseCase(movieDetailRepository: getIt()),
  );

  //* Video Use Case
  getIt.registerSingleton(VideoUseCase(videoRemoteDataSource: getIt()));

  //* Cast Use Case
  getIt.registerSingleton(CastUseCase(castRepository: getIt()));
}
