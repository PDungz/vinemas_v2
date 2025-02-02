import 'package:vinemas_v1/features/home/domain/entity/movie.dart';

abstract class NowPlayingRepository {
  Future<List<Movie>?> getNowPlaying({List<Movie>? movie, String language = 'en', int page = 1});
}
