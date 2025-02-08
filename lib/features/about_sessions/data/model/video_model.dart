import 'package:vinemas_v1/features/about_sessions/domain/entity/video.dart';

class VideoModel extends Video {
  VideoModel({
    required super.iso_639_1,
    required super.iso_3166_1,
    required super.name,
    required super.key,
    required super.site,
    required super.type,
    required super.official,
    required super.publishedAt,
    required super.id,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      iso_639_1: json['iso_639_1'],
      iso_3166_1: json['iso_3166_1'],
      name: json['name'],
      key: json['key'],
      site: json['site'],
      type: json['type'],
      official: json['official'],
      publishedAt: json['published_at'],
      id: json['id'],
    );
  }
}
