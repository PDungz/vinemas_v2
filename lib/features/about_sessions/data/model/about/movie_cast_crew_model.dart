import 'package:vinemas_v1/features/about_sessions/data/model/about/cast_model.dart';
import 'package:vinemas_v1/features/about_sessions/data/model/about/crew_model.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_cast_crew.dart';

class MovieCastCrewModel extends MovieCastCrew {
  MovieCastCrewModel({
    required super.id,
    required super.cast,
    required super.crew,
  });

  factory MovieCastCrewModel.fromJson(Map<String, dynamic> json) {
    return MovieCastCrewModel(
      id: json['id'],
      cast: (json['cast'] as List)
          .map((item) => CastModel.fromJson(item))
          .toList(),
      crew: (json['crew'] as List)
          .map((item) => CrewModel.fromJson(item))
          .toList(),
    );
  }
}
