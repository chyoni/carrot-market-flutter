import 'package:shared_preferences/shared_preferences.dart';

class ConfigRepository {
  static const String _darkMode = "darkMode";

  final SharedPreferences _preferences;

  ConfigRepository(this._preferences);

  Future<void> setDarkMode(bool value) async {
    await _preferences.setBool(_darkMode, value);
  }

  bool getDarkMode() {
    return _preferences.getBool(_darkMode) ?? false;
  }
}
