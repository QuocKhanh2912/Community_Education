import 'package:firebase_database/firebase_database.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';

class UpdateUserInfo {
  static Future<void> updateUserInfo(
      {required DataUserModal userInfo, required String key}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users").child(key);
    await ref.update({
      'name': userInfo.userName,
      'email': userInfo.email,
      'avatarUrl': userInfo.avatarUrl
    });
  }
}
