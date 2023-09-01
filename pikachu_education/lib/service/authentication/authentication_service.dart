import 'package:pikachu_education/domain/repositories/auth_repositories.dart';
import 'package:pikachu_education/service/app_shared_preference.dart';
import 'package:pikachu_education/utils/management_key.dart';

class AuthenticationLocalService {
  late final AppSharePreference _prefs = AppSharePreference();


  Future<void> saveMethodLogin({required String methodLogin}) async {
    await _prefs.saveData(key:  ManagementKey.methodLoginKey,data:  methodLogin);
  }

  Future<void> saveDataUserId({required String userId}) async {
    await _prefs.saveData( key:  ManagementKey.userId, data:  userId);
  }

  Future<void> saveDataUserName({required String userId}) async {
    var currentUserName =
        await AuthRepositories.getCurrentUserName(currentUserID: userId);
    await _prefs.saveData(key:  ManagementKey.userName,data:  currentUserName);
  }

  Future<String> methodLoginCurrent() async {
    return await _prefs.readData<String>(key:  ManagementKey.methodLoginKey)??'';
  }
}
