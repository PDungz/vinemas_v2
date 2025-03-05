// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/about_sessions/data/data_source/about/movie_detail_remote_data_source.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/about/movie_detail_repository.dart';

class MovieDetailRepositoryImpl extends MovieDetailRepository {
  final MovieDetailRemoteDataSource movieDetailRemoteDataSource;

  MovieDetailRepositoryImpl({
    required this.movieDetailRemoteDataSource,
  });

  @override
  Future<MovieDetail?> getMovieDetail(
      {required int movieId, String language = 'en'}) async {
    return await movieDetailRemoteDataSource.getMovieDetail(
        movieId: movieId, language: language);
  }
}
