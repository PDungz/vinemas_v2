// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/home/data/datasource/now_playing_remote_data_source.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/features/home/domain/repository/now_playing_repository.dart';

class NowPlayingRepositoryImpl implements NowPlayingRepository {
  final NowPlayingRemoteDataSource nowPlayingRemoteDataSource;

  NowPlayingRepositoryImpl({
    required this.nowPlayingRemoteDataSource,
  });

  @override
  Future<List<Movie>?> getNowPlaying(
      {String language = 'en', int page = 1}) async {
    return nowPlayingRemoteDataSource.getNowPlaying(
        language: language, page: page);
  }
}
