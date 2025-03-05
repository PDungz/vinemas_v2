// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:vinemas_v1/features/about_sessions/data/data_source/session/session_remote_data_source.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/domain/repository/session/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionRemoteDataSource sessionRemoteDataSource;

  SessionRepositoryImpl({required this.sessionRemoteDataSource});

  @override
  Future<List<CinemaBand>?> getCinemaBand() async {
    return await sessionRemoteDataSource.getCinemaBand();
  }

  @override
  Future<List<Cinema>?> getCinema() async {
    return await sessionRemoteDataSource.getCinema();
  }

  @override
  Future<List<ChairConfig>?> getChairConfig() async {
    return await sessionRemoteDataSource.getChairConfig();
  }

  @override
  Future<List<SessionMovie>?> getSessionMovie() async {
    return await sessionRemoteDataSource.getSessionMovie();
  }
}
