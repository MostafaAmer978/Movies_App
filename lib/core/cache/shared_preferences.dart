import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences preferences;

  static initCache() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(String key, dynamic value) async {
    if (value is String) {
      return preferences.setString(key, value);
    } else if (value is bool) {
      return preferences.setBool(key, value);
    } else if (value is double) {
      return preferences.setDouble(key, value);
    } else if (value is int) {
      return preferences.setInt(key, value);
    } else if (value is List<String>) {
      return preferences.setStringList(key, value);
    } else {
      return false;
    }
  }

  static String? getData(String key) {
    return preferences.getString(key);
  }
}