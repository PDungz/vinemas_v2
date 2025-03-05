import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      seatPrices: _parseSeatPrices(json['seatPrices']),
      chairStatuses: json['chairStatuses'] != null
          ? (json['chairStatuses'] as List)
              .map((status) => ChairStatus.fromJson(status))
              .toList()
          : [],
    );
  }

  static Map<String, Map<String, int>> _parseSeatPrices(dynamic data) {
    if (data == null) return {};

    return (data as Map<String, dynamic>).map(
      (key, value) {
        if (value is Map<String, dynamic>) {
          return MapEntry(
            key,
            value.map((k, v) =>
                MapEntry(k, v is int ? v : int.tryParse(v.toString()) ?? 0)),
          );
        }
        return MapEntry(key, {});
      },
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
      'chairStatuses': chairStatuses.map((status) => status.toJson()).toList(),
    };
  }
}
