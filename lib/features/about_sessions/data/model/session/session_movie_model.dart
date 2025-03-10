import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:vinemas_v1/core/common/extension/seat_extenstion.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';

class SessionMovieModel extends SessionMovie {
  SessionMovieModel({
    required super.sessionMovieId,
    required super.movieId,
    required super.cinemaId,
    required super.startDate,
    required super.endDate,
    required super.description,
    required super.seatPrices,
    required super.chairStatuses,
  });

  factory SessionMovieModel.fromJson(Map<String, dynamic> json) {
    return SessionMovieModel(
      sessionMovieId: json['sessionMovieId'] ?? '',
      movieId: json['movieId'] != null
          ? int.tryParse(json['movieId'].toString()) ?? 0
          : 0,
      cinemaId: json['cinemaId'] ?? '',
      startDate: _parseDate(json['startDate']),
      endDate: _parseDate(json['endDate']),
      description: json['description'] ?? '',
      seatPrices: (json['seatPrices'] != null)
          ? (json['seatPrices'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, value),
            )
          : {},
      chairStatuses: (json['chairStatuses'] != null)
          ? (json['chairStatuses'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                key,
                ChairStatusExtension.fromValue(value as int),
              ),
            )
          : {},
    );
  }

  static DateTime _parseDate(dynamic date) {
    if (date == null) {
      return DateTime.now();
    } else if (date is Timestamp) {
      return date.toDate();
    } else if (date is String) {
      return DateFormat.Hm().parse(date);
    } else {
      throw ArgumentError('Invalid date format: $date');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionMovieId': sessionMovieId,
      'movieId': movieId,
      'cinemaId': cinemaId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'description': description,
      'seatPrices': seatPrices,
      'chairStatuses': chairStatuses.map(
        (key, value) => MapEntry(key, value.value),
      ),
    };
  }
}
