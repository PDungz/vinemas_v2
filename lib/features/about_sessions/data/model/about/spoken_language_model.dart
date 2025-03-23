import 'package:vinemas_v1/features/about_sessions/domain/entity/about/spoken_language.dart';

class SpokenLanguageModel extends SpokenLanguage {
  SpokenLanguageModel({
    required super.englishName,
    required super.iso6391,
    required super.name,
  });

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) {
    return SpokenLanguageModel(
      englishName: json['english_name'],
      iso6391: json['iso_639_1'],
      name: json['name'],
    );
  }
}
