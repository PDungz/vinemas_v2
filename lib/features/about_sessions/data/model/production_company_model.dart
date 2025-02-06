import 'package:vinemas_v1/features/about_sessions/domain/entity/production_company.dart';

class ProductionCompanyModel extends ProductionCompany {
  ProductionCompanyModel({
    required super.id,
    required super.logoPath,
    required super.name,
    required super.originCountry,
  });

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyModel(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['logoPath'],
      originCountry: json['origin_country'],
    );
  }
}
