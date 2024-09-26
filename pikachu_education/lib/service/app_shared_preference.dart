import 'package:shared_preferences/shared_preferences.dart';

class AppSharePreference {
  SharedPreferences? _prefs;

  AppSharePreference() {
    init();
  }

  Future<void> init() async {
    _prefs??= await SharedPreferences.getInstance();
  }

  Future<void> saveData<T>({required String key, required T data}) async {
    if (_prefs == null) {
      init();
    }
    if (data is String) {
      await _prefs?.setString(key, data);
    } else if (data is bool) {
      await _prefs?.setBool(key, data);
    } else if (data is int) {
      await _prefs?.setInt(key, data);
    } else if (data is double) {
      await _prefs?.setDouble(key, data);
    }
  }
  Future<T?> readData<T> ({required String key}) async{
    if (_prefs == null) {
     await init();
    }
    var result = _prefs?.get(key);
    if (result is T){
      return result;
    }
    else {
      return null;
    }

  }
}
