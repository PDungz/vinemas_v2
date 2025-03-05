abstract class SessionMovie {
  final String sessionMovieId;
  final int movieId;
  final String cinemaId;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final Map<String, Map<String, int>> seatPrices;
  final List<ChairStatus> chairStatuses;

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

class ChairStatus {
  final String seatId;
  final String row;
  final int seatNumber;
  final String type;
  final String status;

  ChairStatus({
    required this.seatId,
    required this.row,
    required this.seatNumber,
    required this.type,
    required this.status,
  });

  factory ChairStatus.fromJson(Map<String, dynamic> json) {
    return ChairStatus(
      seatId: json['seatId'],
      row: json['row'],
      seatNumber: json['seatNumber'],
      type: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seatId': seatId,
      'row': row,
      'seatNumber': seatNumber,
      'type': type,
      'status': status,
    };
  }
}
