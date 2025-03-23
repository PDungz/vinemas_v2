import 'package:vinemas_v1/core/global/api/configuration/domain/entity/configuration.dart';

abstract class ConfigurationRepository {
  Future<Configuration?> getConfiguration();
}
