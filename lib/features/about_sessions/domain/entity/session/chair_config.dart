abstract class ChairConfig {
  final String chairConfigId;
  final String layout;
  final num rowCount;
  final num seatsPerRow;
  final Map<String, List<String>> chairTypes;
  final List<Seat> seats;

  ChairConfig({
    required this.chairConfigId,
    required this.layout,
    required this.rowCount,
    required this.seatsPerRow,
    required this.chairTypes,
    required this.seats,
  });
}

class Seat {
  final String seatId;
  final String row;
  final num seatNumber;
  final String type;

  Seat({
    required this.seatId,
    required this.row,
    required this.seatNumber,
    required this.type,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      seatId: json['seatId'],
      row: json['row'],
      seatNumber: json['seatNumber'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seatId': seatId,
      'row': row,
      'seatNumber': seatNumber,
      'type': type,
    };
  }
}
