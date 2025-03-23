import 'package:vinemas_v1/core/global/api/configuration/data/model/image_config_model.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/entity/configuration.dart';

class ConfigurationModel extends Configuration {
  ConfigurationModel({
    required super.changeKeys,
    required ImageConfigModel super.imageConfig,
  });

  factory ConfigurationModel.fromMap(Map<String, dynamic> json) {
    return ConfigurationModel(
      changeKeys: List<String>.from(json['change_keys']),
      imageConfig: ImageConfigModel.fromMap(json['images']),
    );
  }
}
