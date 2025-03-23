import 'package:vinemas_v1/core/global/api/genres/domain/entity/genres.dart';

abstract class GenresRepository {
  Future<List<Genres>?> getGenres();
}
