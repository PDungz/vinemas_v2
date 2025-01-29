import 'package:vinemas_v1/core/global/api/configuration/domain/entity/configuration.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/repository/configuration_repository.dart';

class ConfigurationUseCase {
  final ConfigurationRepository _configurationRepository;

  ConfigurationUseCase(this._configurationRepository);

  Future<Configuration?> getConfiguration() async {
    return await _configurationRepository.getConfiguration();
  }
}
