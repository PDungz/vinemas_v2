import 'package:vinemas_v1/core/global/api/genres/domain/entity/genres.dart';

class GenresModel extends Genres {
  GenresModel({
    required super.id,
    required super.name,
  });

  factory GenresModel.fromJson(Map<String, dynamic> json) {
    return GenresModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
