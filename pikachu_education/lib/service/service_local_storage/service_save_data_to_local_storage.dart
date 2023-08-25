import 'package:flutter/cupertino.dart';
import 'package:pikachu_education/domain/repositories/database_repositories.dart';
import 'package:pikachu_education/utils/management_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveDataToLocal {
  static Future<void> saveDataForLogin(
      BuildContext context, String user, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
    await prefs.setString('password', password);
  }

  static Future<void> saveDataUserId({required String userId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ManagementKey.userId,userId);
  }

  static Future<void> saveDataUserName({required String userId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentUserName = await DatabaseRepositories.getCurrentUserName(currentUserID: userId);
    await prefs.setString(ManagementKey.userName,currentUserName);
  }


}
