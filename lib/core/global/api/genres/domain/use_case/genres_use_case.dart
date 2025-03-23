import 'package:vinemas_v1/core/global/api/genres/domain/entity/genres.dart';
import 'package:vinemas_v1/core/global/api/genres/domain/repository/genres_repository.dart';

class GenresUseCase {
  final GenresRepository repository;

  GenresUseCase(this.repository);

  Future<List<Genres>?> getGenres() async {
    return await repository.getGenres();
  }
}
