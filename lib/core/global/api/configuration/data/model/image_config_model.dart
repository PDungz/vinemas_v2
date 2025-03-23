import 'package:vinemas_v1/core/global/api/configuration/domain/entity/image_config.dart';

class ImageConfigModel extends ImageConfig {
  ImageConfigModel({
    required super.baseUrl,
    required super.secureBaseUrl,
    required super.backdropSizes,
    required super.logoSizes,
    required super.posterSizes,
    required super.profileSizes,
    required super.stillSizes,
  });

  factory ImageConfigModel.fromMap(Map<String, dynamic> json) {
    return ImageConfigModel(
      baseUrl: json['base_url'] as String,
      secureBaseUrl: json['secure_base_url'] as String,
      backdropSizes: List<String>.from(json['backdrop_sizes']),
      logoSizes: List<String>.from(json['logo_sizes']),
      posterSizes: List<String>.from(json['poster_sizes']),
      profileSizes: List<String>.from(json['profile_sizes']),
      stillSizes: List<String>.from(json['still_sizes']),
    );
  }
}
