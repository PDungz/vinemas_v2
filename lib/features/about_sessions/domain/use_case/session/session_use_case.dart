// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/session/session_repository.dart';

class SessionUseCase {
  final SessionRepository sessionRepository;
  SessionUseCase({required this.sessionRepository});

  Future<void> getCinemaBand({
    required void Function({
      required List<CinemaBand>? cinemaBand,
      required String message,
      required ProcessStatus status,
    }) onPressed,
  }) async {
    try {
      final result = await sessionRepository.getCinemaBand();
      onPressed(
        cinemaBand: result,
        message: "Cinema bands fetched successfully",
        status: ProcessStatus.success,
      );
    } catch (e) {
      onPressed(
        cinemaBand: null,
        message: "Failed to fetch cinema bands: $e",
        status: ProcessStatus.failure,
      );
    }
  }

  Future<void> getChairConfig({
    required void Function({
      required List<ChairConfig>? chairConfig,
      required String message,
      required ProcessStatus status,
    }) onPressed,
  }) async {
    try {
      final result = await sessionRepository.getChairConfig();
      onPressed(
        chairConfig: result,
        message: "Chair configurations fetched successfully",
        status: ProcessStatus.success,
      );
    } catch (e) {
      onPressed(
        chairConfig: null,
        message: "Failed to fetch chair configurations: $e",
        status: ProcessStatus.failure,
      );
    }
  }

  Future<void> getCinema({
    required void Function({
      required List<Cinema>? cinema,
      required String message,
      required ProcessStatus status,
    }) onPressed,
  }) async {
    try {
      final result = await sessionRepository.getCinema();
      onPressed(
        cinema: result,
        message: "Cinemas fetched successfully",
        status: ProcessStatus.success,
      );
    } catch (e) {
      onPressed(
        cinema: null,
        message: "Failed to fetch cinemas: $e",
        status: ProcessStatus.failure,
      );
    }
  }

  Future<void> getSessionMovie({
    required void Function({
      required String message,
      required List<SessionMovie>? sessionMovie,
      required ProcessStatus status,
    }) onPressed,
  }) async {
    try {
      final result = await sessionRepository.getSessionMovie();
      onPressed(
        sessionMovie: result,
        message: "Session movies fetched successfully",
        status: ProcessStatus.success,
      );
    } catch (e) {
      onPressed(
        sessionMovie: null,
        message: "Failed to fetch session movies: $e",
        status: ProcessStatus.failure,
      );
    }
  }

  Future<void> updateSessionMovie({required SessionMovie sessionMovie}) async {
    await sessionRepository.updateSessionMovie(sessionMovie: sessionMovie);
  }

  Future<Cinema?> getCinemaDetail({required String cinemaId}) async {
    return await sessionRepository.getCinemaDetail(cinemaId: cinemaId);
  }

  Future<SessionMovie?> getSessionMovieDetail(
      {required String sessionMovieId}) async {
    return await sessionRepository.getSessionMovieDetail(
        sessionMovieId: sessionMovieId);
  }

  Future<void> createSessionMovie({required SessionMovie sessionMovie}) async {
    await sessionRepository.createSessionMovie(sessionMovie: sessionMovie);
  }
}
