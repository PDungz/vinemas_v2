import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';

abstract class SessionRepository {
  Future<List<CinemaBand>?> getCinemaBand();

  Future<List<Cinema>?> getCinema();

  Future<List<ChairConfig>?> getChairConfig();

  Future<List<SessionMovie>?> getSessionMovie();

  Future<void> updateSessionMovie({required SessionMovie sessionMovie});

  Future<Cinema?> getCinemaDetail({required String cinemaId});

  Future<SessionMovie?> getSessionMovieDetail({required String sessionMovieId});

  Future<void> createSessionMovie({required SessionMovie sessionMovie});
}
