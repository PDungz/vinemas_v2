import 'package:vinemas_v1/core/common/extension/gender_extension.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/crew.dart';

class CrewModel extends Crew {
  CrewModel({
    required super.adult,
    required super.gender,
    required super.id,
    required super.knownForDepartment,
    required super.name,
    required super.originalName,
    required super.popularity,
    required super.profilePath,
    required super.creditId,
    required super.department,
    required super.job,
  });

  factory CrewModel.fromJson(Map<String, dynamic> json) {
    return CrewModel(
      adult: json['adult'],
      gender: GenderExtension.fromInt(json['gender']),
      id: json['id'],
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      originalName: json['original_name'],
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] ?? '',
      creditId: json['credit_id'],
      department: json['department'],
      job: json['job'],
    );
  }
}
