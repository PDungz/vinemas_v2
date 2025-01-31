// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:vinemas_v1/core/config/app_url.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/usecase/shared_preference_usecase.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/home/data/model/movie_model.dart';

abstract class UpcomingRemoteDataSource {
  Future<List<MovieModel>?> getUpcoming({String language = 'en', int page = 1});
}

class UpcomingRemoteDataSourceImpl implements UpcomingRemoteDataSource {
  final Dio dio;

  UpcomingRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<MovieModel>?> getUpcoming(
      {String language = 'en', int page = 1}) async {
    try {
      final localeString =
          await getIt<SharedPreferenceUseCase>().getData('language') ??
              language;
      final response = await dio.get(
        AppUrl.apiMovieListUpcoming,
        queryParameters: {
          'language': localeString,
          'page': page,
        },
      );
      final List<dynamic> data = response.data['results'];
      return data
          .map(
            (json) => MovieModel.fromJson(json),
          )
          .toList();
    } catch (e) {
      printE("Error in UpcomingRemoteDataSourceImpl: $e");
    }
    return null;
  }
}
