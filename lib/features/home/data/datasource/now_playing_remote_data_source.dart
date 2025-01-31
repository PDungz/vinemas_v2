// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:vinemas_v1/core/config/app_url.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/usecase/shared_preference_usecase.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/home/data/model/movie_model.dart';

abstract class NowPlayingRemoteDataSource {
  Future<List<MovieModel>?> getNowPlaying(
      {String language = 'en', int page = 1});
}

class NowPlayingRemoteDataSourceImpl implements NowPlayingRemoteDataSource {
  final Dio dio;

  NowPlayingRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<MovieModel>?> getNowPlaying(
      {String language = 'en', int page = 1}) async {
    try {
      final localString =
          await getIt<SharedPreferenceUseCase>().getData('language') ??
              language;
      final response =
          await dio.get(AppUrl.apiMovieListNowPlaying, queryParameters: {
        'language': localString,
        'page': page,
      });
      final List<dynamic> data = response.data['results'];
      return data
          .map(
            (json) => MovieModel.fromJson(json),
          )
          .toList();
    } catch (e) {
      printE("Error in NowPlayingRemoteDataSourceImpl: $e");
    }
    return null;
  }
}
