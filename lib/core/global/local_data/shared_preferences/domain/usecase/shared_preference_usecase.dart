import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/repository/shared_preference_repository.dart';

class SharedPreferenceUseCase {
  final SharedPreferenceRepository _sharedPreferenceRepository;

  SharedPreferenceUseCase(this._sharedPreferenceRepository);

  Future<void> saveData(String key, value) async {
    await _sharedPreferenceRepository.saveData(key, value);
  }

  Future getData(String key) async {
    return await _sharedPreferenceRepository.getData(key);
  }

  Future<void> removeData(String key) async {
    await _sharedPreferenceRepository.removeData(key);
  }

  Future<void> clearData() async {
    await _sharedPreferenceRepository.clearData();
  }
}
