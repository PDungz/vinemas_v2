// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/core/global/api/genres/data/datasource/genres_remote_data_source.dart';
import 'package:vinemas_v1/core/global/api/genres/domain/entity/genres.dart';
import 'package:vinemas_v1/core/global/api/genres/domain/repository/genres_repository.dart';

class GenresRepositoryImpl implements GenresRepository {
  final GenresRemoteDataSource genresRemoteDataSource;

  GenresRepositoryImpl({
    required this.genresRemoteDataSource,
  });

  @override
  Future<List<Genres>?> getGenres() async {
    final genres = await genresRemoteDataSource.getGenres();
    return genres;
  }
}
