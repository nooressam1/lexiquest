import 'package:shared_preferences/shared_preferences.dart';

class Sharedpreferences {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveUserId(String userId) async {
    await _prefs?.setString("userId", userId);
    print('Saved UID: $userId');
  }

 static Future<String?> getUserId() async {
  return _prefs?.getString("userId");
}


  static Future<void> saveTheme(bool isDark) async {
    await _prefs?.setBool("isDarkTheme", isDark);
  }

  static bool getTheme() {
    return _prefs?.getBool("isDarkTheme") ?? false;
  }

  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
