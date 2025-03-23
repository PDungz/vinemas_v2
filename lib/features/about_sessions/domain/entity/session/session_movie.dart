// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/core/common/enum/seat_enum.dart';

class SessionMovie {
  final String sessionMovieId;
  final int movieId;
  final String cinemaId;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final Map<String, num> seatPrices;
  final Map<String, ChairStatus> chairStatuses;

  SessionMovie({
    required this.sessionMovieId,
    required this.movieId,
    required this.cinemaId,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.seatPrices,
    required this.chairStatuses,
  });

  SessionMovie copyWith({
    String? sessionMovieId,
    int? movieId,
    String? cinemaId,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    Map<String, num>? seatPrices,
    Map<String, ChairStatus>? chairStatuses,
  }) {
    return SessionMovie(
      sessionMovieId: sessionMovieId ?? this.sessionMovieId,
      movieId: movieId ?? this.movieId,
      cinemaId: cinemaId ?? this.cinemaId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      seatPrices: seatPrices ?? this.seatPrices,
      chairStatuses: chairStatuses ?? this.chairStatuses,
    );
  }
}
