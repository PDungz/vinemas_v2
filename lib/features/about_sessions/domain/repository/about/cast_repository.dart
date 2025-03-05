import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_cast_crew.dart';

abstract class CastRepository {
  Future<MovieCastCrew?> getCast(
      {required int movieId, String language = 'en'});
}
