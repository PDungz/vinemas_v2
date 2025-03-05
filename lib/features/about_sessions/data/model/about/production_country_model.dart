import 'package:vinemas_v1/features/about_sessions/domain/entity/about/production_country.dart';

class ProductionCountryModel extends ProductionCountry {
  ProductionCountryModel({
    required super.iso31661,
    required super.name,
  });

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) {
    return ProductionCountryModel(
      iso31661: json['iso_3166_1'],
      name: json['name'],
    );
  }
}
