// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/features/home/domain/repository/now_playing_repository.dart';

class NowPlayingUseCase {
  final NowPlayingRepository nowPlayingRepository;

  NowPlayingUseCase({
    required this.nowPlayingRepository,
  });

  Future<List<Movie>?> getNowPlaying(
      {List<Movie>? movie, String language = 'en', int page = 1}) async {
    return await nowPlayingRepository.getNowPlaying(
        movie: movie, language: language, page: page);
  }
}
