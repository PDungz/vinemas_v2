import 'package:vinemas_v1/features/about_sessions/domain/entity/cast.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/crew.dart';

class MovieCastCrew {
  final int id;
  final List<Cast> cast;
  final List<Crew> crew;

  MovieCastCrew({
    required this.id,
    required this.cast,
    required this.crew,
  });
}
