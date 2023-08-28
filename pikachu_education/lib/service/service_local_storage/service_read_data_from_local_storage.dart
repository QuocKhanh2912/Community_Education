import 'package:pikachu_education/utils/management_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadDataFromLocal {
 static Future<String> methodLoginCurrent() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(ManagementKey.methodLoginKey)??'';
}
 static Future<bool> onBoardingAlready() async{
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getBool(ManagementKey.onBoardingAlready)??false;
 }
}