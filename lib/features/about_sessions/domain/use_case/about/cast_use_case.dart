// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_cast_crew.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/about/cast_repository.dart';

class CastUseCase {
  final CastRepository castRepository;

  CastUseCase({
    required this.castRepository,
  });

  Future<MovieCastCrew?> getCast(
      {required int movieId, String language = 'en'}) async {
    return await castRepository.getCast(movieId: movieId);
  }
}
