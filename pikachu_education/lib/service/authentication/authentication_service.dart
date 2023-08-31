import 'package:pikachu_education/domain/repositories/auth_repositories.dart';
import 'package:pikachu_education/service/app_shared_preference.dart';
import 'package:pikachu_education/utils/management_key.dart';

class AuthenticationLocalService {
  final AppSharedPreference _appPrefs = AppSharedPreference();

  Future<void> saveMethodLogin({required String methodLogin}) async {
    await _appPrefs.saveData(ManagementKey.methodLoginKey, methodLogin);
  }

  Future<void> saveDataUserId({required String userId}) async {
    await _appPrefs.saveData(ManagementKey.userId, userId);
  }

  Future<void> saveDataUserName({required String userId}) async {
    var currentUserName =
        await AuthRepositories.getCurrentUserName(currentUserID: userId);
    await _appPrefs.saveData(ManagementKey.userName, currentUserName);
  }

  Future<String> methodLoginCurrent() async {
    return await _appPrefs.readData<String>(ManagementKey.methodLoginKey) ?? '';
  }
}
