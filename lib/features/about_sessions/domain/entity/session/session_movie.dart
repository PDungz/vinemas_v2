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
}