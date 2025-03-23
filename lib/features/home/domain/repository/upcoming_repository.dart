import 'package:vinemas_v1/features/home/domain/entity/movie.dart';

abstract class UpcomingRepository {
  Future<List<Movie>?> getUpcomming({String language = 'en', int page = 1});
}
