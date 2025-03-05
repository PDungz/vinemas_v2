// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:vinemas_v1/core/config/app_url.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/use_case/shared_preference_use_case.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/about_sessions/data/model/about/video_model.dart';

abstract class VideoRemoteDataSource {
  Future<List<VideoModel>?> getVideo(
      {required int movieId, String language = 'en'});
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  final Dio dio;

  VideoRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<VideoModel>?> getVideo(
      {required int movieId, String language = 'en'}) async {
    final String localLanguage =
        await getIt<SharedPreferenceUseCase>().getData('language') ?? language;

    try {
      final response = await dio.get(
        AppUrl.movieVideos(movieId),
        queryParameters: {
          'language': localLanguage,
        },
      );

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['results'] is List &&
          response.data['results'].length > 0) {
        final List<dynamic> data = response.data['results'];
        return data.map((json) => VideoModel.fromJson(json)).toList();
      } else {
        final response = await dio.get(
          AppUrl.movieVideos(movieId),
          queryParameters: {
            'language': 'en',
          },
        );
        if (response.statusCode == 200 &&
            response.data != null &&
            response.data['results'] is List &&
            response.data['results'].length > 0) {
          final List<dynamic> data = response.data['results'];
          return data.map((json) => VideoModel.fromJson(json)).toList();
        }
      }
    } catch (e) {
      printE("Error in VideoRemoteDatasourceImpl: $e");
    }
    return null;
  }
}
