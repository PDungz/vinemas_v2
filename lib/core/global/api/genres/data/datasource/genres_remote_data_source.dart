import 'package:dio/dio.dart';
import 'package:vinemas_v1/core/config/app_url.dart';
import 'package:vinemas_v1/core/global/api/genres/data/model/genres_model.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';

abstract class GenresRemoteDataSource {
  Future<List<GenresModel>?> getGenres();
}

class GenresRemoteDataSourceImpl implements GenresRemoteDataSource {
  final Dio dio;

  GenresRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<GenresModel>?> getGenres() async {
    try {
      final response = await dio.get(AppUrl.apiGenresMovieList);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['genres'];
        return data.map((e) => GenresModel.fromJson(e)).toList();
      }
    } catch (e) {
      printE("Error in GenresRemoteDataSourceImpl: $e");
    }
    return null;
  }
}
