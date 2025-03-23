import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';

class CinemaBandModel extends CinemaBand {
  CinemaBandModel({
    super.cinemaBandId,
    super.imageUrl,
    super.nameCinema,
    super.openDate,
    super.closeDate,
  });

  CinemaBandModel copyWith({
    String? cinemaBandId,
    String? imageUrl,
    String? nameCinema,
    String? openDate,
    String? closeDate,
  }) {
    return CinemaBandModel(
      cinemaBandId: cinemaBandId ?? this.cinemaBandId,
      imageUrl: imageUrl ?? this.imageUrl,
      nameCinema: nameCinema ?? this.nameCinema,
      openDate: openDate ?? this.openDate,
      closeDate: closeDate ?? this.closeDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cinemaBandId': cinemaBandId,
      'imageUrl': imageUrl,
      'nameCinema': nameCinema,
      'openDate': openDate,
      'closeDate': closeDate,
    };
  }

  factory CinemaBandModel.fromJson(Map<String, dynamic> map) {
    return CinemaBandModel(
      cinemaBandId:
          map['cinemaBandId'] != null ? map['cinemaBandId'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      nameCinema:
          map['nameCinema'] != null ? map['nameCinema'] as String : null,
      openDate: map['openDate'] != null ? map['openDate'] as String : null,
      closeDate: map['closeDate'] != null ? map['closeDate'] as String : null,
    );
  }
}
