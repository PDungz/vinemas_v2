abstract class SharedPreferenceRepository {
  Future<void> saveData(String key, dynamic value);
  Future<dynamic> getData(String key);
  Future<void> removeData(String key);
  Future<void> clearData();
  Future<void> updateData(String key, dynamic newValue);
}
