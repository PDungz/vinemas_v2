import 'package:vinemas_v1/features/about_sessions/domain/entity/movie_detail.dart';

abstract class MovieDetailRepository {
  Future<MovieDetail?> getMovieDetail(
      {required String id, String language = 'en'});
}
