// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/about_sessions/data/data_source/about/video_remote_data_source.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/video.dart';

class VideoUseCase {
  final VideoRemoteDataSource videoRemoteDataSource;

  VideoUseCase({
    required this.videoRemoteDataSource,
  });

  Future<List<Video>?> getVideo(
      {required int movieId, String language = 'en'}) async {
    return await videoRemoteDataSource.getVideo(movieId: movieId, language: language);
  }
}
