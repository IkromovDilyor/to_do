import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceStorage {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setString({
    required String key,
    required String value,
  }) async {
    return _preferences?.setString(key, value) ?? false;
  }

  static String getString(String key) {
    return _preferences?.getString(key) ?? "";
  }

  static Future<bool> setInt({required String key, required int value}) async {
    return _preferences?.setInt(key, value) ?? false;
  }

  static int getInt(String key) {
    return _preferences?.getInt(key) ?? 0;
  }

  static Future<bool> setBool({
    required String key,
    required bool value,
  }) async {
    return _preferences?.setBool(key, value) ?? false;
  }

  static bool getBool(String key) {
    return _preferences?.getBool(key) ?? false;
  }

  static Future<bool> remove(String key) async {
    return await _preferences?.remove(key) ?? false;
  }

  static Future<bool> clearCache() async {
    return await _preferences?.clear() ?? false;
  }
}
