// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/about/movie_detail_repository.dart';

class MovieDetailUseCase {
  final MovieDetailRepository movieDetailRepository;

  MovieDetailUseCase({
    required this.movieDetailRepository,
  });

  Future<MovieDetail?> getMovieDetail(
      {required int movieId, String language = 'en'}) async {
    return await movieDetailRepository.getMovieDetail(
        movieId: movieId, language: language);
  }
}
