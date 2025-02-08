import 'package:vinemas_v1/features/about_sessions/domain/entity/video.dart';

abstract class VideoRepository {
  Future<List<Video>?> getVideo({required int movieId, String language = 'en'});
}
