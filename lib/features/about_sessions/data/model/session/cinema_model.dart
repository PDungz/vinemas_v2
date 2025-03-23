import 'package:intl/intl.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';

class CinemaModel extends Cinema {
  CinemaModel(
      {required super.cinemaId,
      required super.nameCinema,
      required super.cinemaBandId,
      required super.address,
      required super.openDate,
      required super.closeDate,
      required super.description,
      required super.chairConfigId});

  factory CinemaModel.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat.Hm();
    return CinemaModel(
      cinemaId: json['cinemaId'] ?? '',
      nameCinema: json['nameCinema'],
      cinemaBandId: json['cinemaBandId'],
      address: json['address'] ?? '',
      openDate: dateFormat.parse(json['openDate']),
      closeDate: dateFormat.parse(json['closeDate']),
      description: json['description'] ?? '',
      chairConfigId: json['chairConfigId'],
    );
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat.Hm();
    return {
      'cinemaId': cinemaId,
      'nameCinema': nameCinema,
      'cinemaBandId': cinemaBandId,
      'address': address,
      'openDate': dateFormat.format(openDate),
      'closeDate': dateFormat.format(closeDate),
      'description': description,
      'chairConfigId': chairConfigId,
    };
  }

  CinemaModel copyWith({
    String? cinemaId,
    String? nameCinema,
    String? cinemaBandId,
    String? address,
    DateTime? openDate,
    DateTime? closeDate,
    String? description,
    String? chairConfigId,
  }) {
    return CinemaModel(
      cinemaId: cinemaId ?? this.cinemaId,
      nameCinema: nameCinema ?? this.nameCinema,
      cinemaBandId: cinemaBandId ?? this.cinemaBandId,
      address: address ?? this.address,
      openDate: openDate ?? this.openDate,
      closeDate: closeDate ?? this.closeDate,
      description: description ?? this.description,
      chairConfigId: chairConfigId ?? this.chairConfigId,
    );
  }
}
