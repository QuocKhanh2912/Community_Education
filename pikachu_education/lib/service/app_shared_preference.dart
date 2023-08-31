import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  SharedPreferences? _prefs;

  AppSharedPreference() {
    init();
  }

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> saveData<T>(String key, T data) async {
    if (_prefs == null) await init();
    if (data is String) {
      await _prefs?.setString('user', data);
    } else if (data is bool) {
      await _prefs?.setBool('user', data);
    } else if (data is double) {
      await _prefs?.setDouble('user', data);
    } else if (data is int) {
      await _prefs?.setInt('user', data);
    }
  }

  Future<T?> readData<T>(String key) async {
    if (_prefs == null) await init();
    var result = _prefs?.get(key);
    if (result is T) {
      return result;
    } else {
      return null;
    }
  }
}
