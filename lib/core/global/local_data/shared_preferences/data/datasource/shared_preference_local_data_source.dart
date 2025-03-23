import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';

abstract class SharedPreferenceLocalDataSource {
  Future<void> saveData(String key, dynamic value);
  Future<dynamic> getData(String key);
  Future<void> removeData(String key);
  Future<void> clearData();
  Future<void> updateData(String key, dynamic newValue);
}

class SharedPreferenceLocalDataSourceImpl
    implements SharedPreferenceLocalDataSource {
  final SharedPreferences sharedPreferences;

  SharedPreferenceLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveData(String key, dynamic value) async {
    try {
      if (value is String) {
        await sharedPreferences.setString(key, value);
      } else if (value is int) {
        await sharedPreferences.setInt(key, value);
      } else if (value is double) {
        await sharedPreferences.setDouble(key, value);
      } else if (value is bool) {
        await sharedPreferences.setBool(key, value);
      } else if (value is List<String>) {
        await sharedPreferences.setStringList(key, value);
      }
      printS("[SharedPreferenceLocalDataSourceImpl] saveData: [$key: $value]");
    } catch (e) {
      printE(
          "[SharedPreferenceLocalDataSourceImpl] saveData: [$key: $value] - Error: $e");
    }
  }

  @override
  Future<dynamic> getData(String key) async {
    try {
      final dynamic value = sharedPreferences.get(key);
      printS("[SharedPreferenceLocalDataSourceImpl] getData: [$key: $value]");
      return value;
    } catch (e) {
      printE(
          "[SharedPreferenceLocalDataSourceImpl] getData: [$key] - Error: $e");
      return null;
    }
  }

  @override
  Future<void> removeData(String key) async {
    try {
      await sharedPreferences.remove(key);
      printS("[SharedPreferenceLocalDataSourceImpl] removeData: [$key]");
    } catch (e) {
      printE(
          "[SharedPreferenceLocalDataSourceImpl] removeData: [$key] - Error: $e");
    }
  }

  @override
  Future<void> clearData() async {
    try {
      await sharedPreferences.clear();
      printS("[SharedPreferenceLocalDataSourceImpl] clearData");
    } catch (e) {
      printE("[SharedPreferenceLocalDataSourceImpl] clearData - Error: $e");
    }
  }

  @override
  Future<void> updateData(String key, dynamic newValue) async {
    final sharePreference = await SharedPreferences.getInstance();
    if (sharePreference.containsKey(key)) {
      await saveData(key, newValue);
    } else {
      throw Exception("Key not found: $key");
    }
  }
}
