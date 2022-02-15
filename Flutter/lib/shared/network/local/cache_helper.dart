import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    return await sharedPreferences.setInt(key, value);
  }

  static dynamic get({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({required key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearData({key}) async {
    return await sharedPreferences.clear();
  }
}
