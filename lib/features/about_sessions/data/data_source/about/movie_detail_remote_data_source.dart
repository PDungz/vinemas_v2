// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:vinemas_v1/core/config/app_url.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/use_case/shared_preference_use_case.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/about_sessions/data/model/about/movie_detail_model.dart';

abstract class MovieDetailRemoteDataSource {
  Future<MovieDetailModel?> getMovieDetail(
      {required int movieId, String language = 'en'});
}

class MovieDetailRemoteDataSourceImpl implements MovieDetailRemoteDataSource {
  final Dio dio;

  MovieDetailRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<MovieDetailModel?> getMovieDetail(
      {required int movieId, String language = 'en'}) async {
    final localLanguage =
        await getIt<SharedPreferenceUseCase>().getData('language') ?? language;
    try {
      final response = await dio.get(
        AppUrl.movieDetails(movieId),
        queryParameters: {
          'language': localLanguage,
        },
      );

      if (response.data != null && response.statusCode == 200) {
        return MovieDetailModel.fromJson(response.data);
      }
    } catch (e) {
      printE("Error in MovieDetailRemoteDatasourceImpl: $e");
    }
    return null;
  }
}
