import 'package:vinemas_v1/features/about_sessions/data/model/movie_detail_model.dart';

abstract class MovieDetailRemoteDataSource {
  Future<MovieDetailModel?> getMovieDetail(
      {required String id, String language = 'en'});
}
