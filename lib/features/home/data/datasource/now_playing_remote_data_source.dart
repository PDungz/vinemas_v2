// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:vinemas_v1/core/config/app_url.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/use_case/shared_preference_use_case.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/home/data/model/movie_model.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';

abstract class NowPlayingRemoteDataSource {
  Future<List<MovieModel>?> getNowPlaying({
    List<Movie>? movie,
    String language,
    int page,
  });
}

class NowPlayingRemoteDataSourceImpl implements NowPlayingRemoteDataSource {
  final Dio dio;

  NowPlayingRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MovieModel>?> getNowPlaying({
    List<Movie>? movie,
    String language = 'en',
    int page = 1,
  }) async {
    try {
      // Lấy giá trị ngôn ngữ từ SharedPreference hoặc sử dụng mặc định
      final localLanguage =
          await getIt<SharedPreferenceUseCase>().getData('language') ??
              language;

      final response = await dio.get(
        AppUrl.apiMovieListNowPlaying,
        queryParameters: {
          'language': localLanguage,
          'page': page,
        },
      );

      if (response.data != null && response.data['results'] is List) {
        final newMovies = (response.data['results'] as List)
            .map((json) => MovieModel.fromJson(json))
            .toList();

        final existingMovies =
            movie?.map((m) => MovieModel.fromEntity(m)).toList() ?? [];

        final updatedMovies = existingMovies..addAll(newMovies);
        return updatedMovies;
      } else {
        printE("Invalid data format in API response.");
      }
    } catch (e, stackTrace) {
      printE("Error in NowPlayingRemoteDataSourceImpl: $e");
      printE("Stack trace: $stackTrace");
    }
    return null;
  }
}
