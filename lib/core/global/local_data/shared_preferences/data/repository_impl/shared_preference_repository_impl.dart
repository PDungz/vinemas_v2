// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/core/global/local_data/shared_preferences/data/datasource/shared_preference_local_data_source.dart';
import 'package:vinemas_v1/core/global/local_data/shared_preferences/domain/repository/shared_preference_repository.dart';

class SharedPreferenceRepositoryImpl implements SharedPreferenceRepository {
  final SharedPreferenceLocalDataSource sharedPreferenceLocalDataSource;

  SharedPreferenceRepositoryImpl({
    required this.sharedPreferenceLocalDataSource,
  });

  @override
  Future<void> saveData(String key, value) async {
    await sharedPreferenceLocalDataSource.saveData(key, value);
  }

  @override
  Future getData(String key) async {
    return await sharedPreferenceLocalDataSource.getData(key);
  }

  @override
  Future<void> removeData(String key) async {
    await sharedPreferenceLocalDataSource.removeData(key);
  }

  @override
  Future<void> clearData() async {
    await sharedPreferenceLocalDataSource.clearData();
  }

  @override
  Future<void> updateData(String key, dynamic newValue) async {
    await sharedPreferenceLocalDataSource.updateData(key, newValue);
  }
}
