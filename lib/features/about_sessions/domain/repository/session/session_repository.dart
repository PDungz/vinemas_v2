import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';

abstract class SessionRepository {
  Future<List<CinemaBand>?> getCinemaBand();

  Future<List<Cinema>?> getCinema();

  Future<List<ChairConfig>?> getChairConfig();

  Future<List<SessionMovie>?> getSessionMovie();
}
