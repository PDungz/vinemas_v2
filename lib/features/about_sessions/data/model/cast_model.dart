import 'package:vinemas_v1/core/common/extension/gender_extension.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/cast.dart';

class CastModel extends Cast {
  CastModel({
    required super.adult,
    required super.gender,
    required super.id,
    required super.knownForDepartment,
    required super.name,
    required super.originalName,
    required super.popularity,
    required super.profilePath,
    required super.castId,
    required super.character,
    required super.creditId,
    required super.order,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      adult: json['adult'],
      gender: GenderExtension.fromInt(json['gender']),
      id: json['id'],
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      originalName: json['original_name'],
      popularity: json['popularity'].toDouble(),
      profilePath: json['profile_path'] ?? '',
      castId: json['cast_id'],
      character: json['character'],
      creditId: json['credit_id'],
      order: json['order'],
    );
  }
}
