// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/about_sessions/data/data_source/about/cast_remote_data_source.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_cast_crew.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/about/cast_repository.dart';

class CastRepositoryImpl implements CastRepository {
  final CastRemoteDataSource castRemoteDataSource;

  CastRepositoryImpl({
    required this.castRemoteDataSource,
  });

  @override
  Future<MovieCastCrew?> getCast(
      {required int movieId, String language = 'en'}) async {
    return await castRemoteDataSource.getCast(movieId: movieId);
  }
}
