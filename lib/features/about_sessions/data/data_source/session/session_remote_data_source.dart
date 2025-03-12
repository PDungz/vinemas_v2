import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/about_sessions/data/model/session/chair_config_model.dart';
import 'package:vinemas_v1/features/about_sessions/data/model/session/cinema_band_model.dart';
import 'package:vinemas_v1/features/about_sessions/data/model/session/cinema_model.dart';
import 'package:vinemas_v1/features/about_sessions/data/model/session/session_movie_model.dart';

abstract class SessionRemoteDataSource {
  Future<List<CinemaBandModel>> getCinemaBand();
  Future<List<CinemaModel>> getCinema();
  Future<List<ChairConfigModel>> getChairConfig();
  Future<List<SessionMovieModel>> getSessionMovie();
  Future<void> updateSessionMovie({required SessionMovieModel sessionMovie});
}

class SessionRemoteDataSourceImpl implements SessionRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<CinemaBandModel>> getCinemaBand() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('cinemaBands').get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['cinemaBandId'] = doc.id;
        return CinemaBandModel.fromJson(data);
      }).toList();
    } catch (e) {
      printE("Error in SessionRemoteDataSourceImpl - getCinemaBand: $e");
      throw Exception("Failed to fetch Cinema Bands: $e");
    }
  }

  @override
  Future<List<CinemaModel>> getCinema() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('cinemaInfo').get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['cinemaId'] = doc.id;
        return CinemaModel.fromJson(data);
      }).toList();
    } catch (e) {
      printE("Error in SessionRemoteDataSourceImpl - getCinema: $e");
      throw Exception("Failed to fetch Cinemas: $e");
    }
  }

  @override
  Future<List<ChairConfigModel>> getChairConfig() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('chairConfig').get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['chairConfigId'] = doc.id;
        return ChairConfigModel.fromJson(data);
      }).toList();
    } catch (e) {
      printE("Error in SessionRemoteDataSourceImpl - getChairConfig: $e");
      throw Exception("Failed to fetch Chair Config: $e");
    }
  }

  @override
  Future<List<SessionMovieModel>> getSessionMovie() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('sessionMovie').get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['sessionMovieId'] = doc.id;
        return SessionMovieModel.fromJson(data);
      }).toList();
    } catch (e) {
      printE("Error in SessionRemoteDataSourceImpl - getSessionMovie: $e");
      throw Exception("Failed to fetch Session Movies: $e");
    }
  }

  @override
  Future<void> updateSessionMovie(
      {required SessionMovieModel sessionMovie}) async {
    try {
      await _firestore
          .collection('sessionMovie')
          .doc(sessionMovie.sessionMovieId)
          .update(sessionMovie.toJson());
    } catch (e) {
      printE("Error in SessionRemoteDataSourceImpl - getSessionMovie: $e");
      throw Exception("Failed to fetch Session Movies: $e");
    }
  }
}
