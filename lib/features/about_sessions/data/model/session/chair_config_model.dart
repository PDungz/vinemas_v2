import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';

class ChairConfigModel extends ChairConfig {
  ChairConfigModel({
    required super.chairConfigId,
    required super.layout,
    required super.rowCount,
    required super.seatsPerRow,
    required super.chairTypes,
    required super.seats,
  });

  factory ChairConfigModel.fromJson(Map<String, dynamic> json) {
    return ChairConfigModel(
      chairConfigId: json['chairConfigId'],
      layout: json['layout'],
      rowCount: json['rowCount'],
      seatsPerRow: json['seatsPerRow'],
      chairTypes: (json['chairTypes'] != null)
          ? (json['chairTypes'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                  key,
                  value != null
                      ? List<String>.from(value as List)
                      : <String>[]),
            )
          : {},
      seats: (json['seats'] as List?)
              ?.map((seat) => Seat.fromJson(seat))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chairConfigId': chairConfigId,
      'layout': layout,
      'rowCount': rowCount,
      'seatsPerRow': seatsPerRow,
      'chairTypes': chairTypes,
      'seats': seats.map((seat) => seat.toJson()).toList(),
    };
  }
}
