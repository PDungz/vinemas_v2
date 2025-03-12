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
import 'package:vinemas_v1/features/about_sessions/data/data_source/about/cast_remote_data_source.dart';
import 'package:vinemas_v1/features/about_sessions/data/data_source/about/movie_detail_remote_data_source.dart';
import 'package:vinemas_v1/features/about_sessions/data/data_source/about/video_remote_data_source.dart';
import 'package:vinemas_v1/features/about_sessions/data/data_source/session/session_remote_data_source.dart';
import 'package:vinemas_v1/features/about_sessions/data/repository/about/cast_repository_impl.dart';
import 'package:vinemas_v1/features/about_sessions/data/repository/about/movie_detail_repository_impl.dart';
import 'package:vinemas_v1/features/about_sessions/data/repository/about/video_repository_impl.dart';
import 'package:vinemas_v1/features/about_sessions/data/repository/session/session_repository_impl.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/about/cast_repository.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/about/movie_detail_repository.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/about/video_repository.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/session/session_repository.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/about/cast_use_case.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/about/movie_detail_use_case.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/about/video_use_case.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/session/session_use_case.dart';
import 'package:vinemas_v1/features/home/data/datasource/now_playing_remote_data_source.dart';
import 'package:vinemas_v1/features/home/data/datasource/upcoming_remote_data_source.dart';
import 'package:vinemas_v1/features/home/data/repository_impl/now_playing_repository_impl.dart';
import 'package:vinemas_v1/features/home/data/repository_impl/upcoming_repository_impl.dart';
import 'package:vinemas_v1/features/home/domain/repository/now_playing_repository.dart';
import 'package:vinemas_v1/features/home/domain/repository/upcoming_repository.dart';
import 'package:vinemas_v1/features/home/domain/use_case/now_playing_use_case.dart';
import 'package:vinemas_v1/features/home/domain/use_case/upcoming_use_case.dart';
import 'package:vinemas_v1/features/login/data/data_source/user_remote_data_source.dart';
import 'package:vinemas_v1/features/login/data/repository_impl/user_repository_impl.dart';
import 'package:vinemas_v1/features/login/domain/repository/user_repository.dart';
import 'package:vinemas_v1/features/login/domain/use_case/user_use_case.dart';
import 'package:vinemas_v1/features/pay/data/data_source/payment_remote_data_source.dart';
import 'package:vinemas_v1/features/pay/data/repository_impl/payment_repository_impl.dart';
import 'package:vinemas_v1/features/pay/domain/repository/payment_repository.dart';
import 'package:vinemas_v1/features/pay/domain/use_case/payment_use_case.dart';
import 'package:vinemas_v1/features/ticket/data/data_source/ticket_remote_data_source.dart';
import 'package:vinemas_v1/features/ticket/data/repository_impl/ticket_repository_impl.dart';
import 'package:vinemas_v1/features/ticket/domain/repository/ticket_repository.dart';
import 'package:vinemas_v1/features/ticket/domain/use_case/ticket_use_case.dart';

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

  // * Remote Data User
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );

  // * Remote Data Session
  getIt.registerLazySingleton<SessionRemoteDataSource>(
    () => SessionRemoteDataSourceImpl(),
  );

  // * Remote Data Ticket
  getIt.registerLazySingleton<TicketRemoteDataSource>(
    () => TicketRemoteDataSourceImpl(),
  );

  // * Remote Data Payment
  getIt.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(),
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

  //* User Repository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemoteDataSource: getIt()),
  );

  //* Session Repository
  getIt.registerLazySingleton<SessionRepository>(
    () => SessionRepositoryImpl(sessionRemoteDataSource: getIt()),
  );

  // * Ticket Repository
  getIt.registerLazySingleton<TicketRepository>(
    () => TicketRepositoryImpl(ticketRemoteDataSource: getIt()),
  );

  // * Payment Repository
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(paymentRemoteDataSource: getIt()),
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

  //* User Use Case
  getIt.registerSingleton(UserUseCase(userRepository: getIt()));

  //* Session Use Case
  getIt.registerSingleton(SessionUseCase(sessionRepository: getIt()));

  //* Ticket Use Case
  getIt.registerSingleton(TicketUseCase(ticketRepository: getIt()));

  //* Payment Use Case
  getIt.registerSingleton(PaymentUseCase(paymentRepository: getIt()));
}
