import 'package:pikachu_education/utils/management_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitializationService {
  static Future<void> saveOnBoardingAlready() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ManagementKey.onBoardingAlready, true);
  }

  static Future<bool> onBoardingAlready() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(ManagementKey.onBoardingAlready) ?? false;
  }
}
