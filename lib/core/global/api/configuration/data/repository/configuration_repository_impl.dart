// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/core/global/api/configuration/data/datasources/configuration_remote_data_source.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/entity/configuration.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/repository/configuration_repository.dart';

class ConfigurationRepositoryImpl implements ConfigurationRepository {
  ConfigurationRemoteDataSource configurationRemoteDataSource;

  ConfigurationRepositoryImpl({
    required this.configurationRemoteDataSource,
  });

  @override
  Future<Configuration?> getConfiguration() async {
    return await configurationRemoteDataSource.getConfiguration();
  }
}
