// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/home/data/datasource/upcoming_remote_data_source.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/features/home/domain/repository/upcoming_repository.dart';

class UpcomingRepositoryImpl implements UpcomingRepository {
  final UpcomingRemoteDataSource upcomingRemoteDataSource;

  UpcomingRepositoryImpl({
    required this.upcomingRemoteDataSource,
  });

  @override
  Future<List<Movie>?> getUpcomming(
      {String language = 'en', int page = 1}) async {
    return await upcomingRemoteDataSource.getUpcoming(
      language: language,
      page: page,
    );
  }
}
