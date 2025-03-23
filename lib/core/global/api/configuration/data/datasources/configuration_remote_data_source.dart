// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:vinemas_v1/core/global/api/configuration/data/model/configuration_model.dart';
import 'package:vinemas_v1/core/config/app_url.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';

abstract class ConfigurationRemoteDataSource {
  Future<ConfigurationModel?> getConfiguration();
}

class ConfigurationRemoteDataSourceImpl
    implements ConfigurationRemoteDataSource {
  final Dio dio;
  ConfigurationRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<ConfigurationModel?> getConfiguration() async {
    try {
      final response = await dio.get(AppUrl.apiConfigurationDetails);
      if (response.statusCode == 200) {
        return ConfigurationModel.fromMap(response.data);
      }
    } catch (e) {
      printE("Error in ConfigurationRemoteDataSourceImpl: $e");
    }
    return null;
  }
}
