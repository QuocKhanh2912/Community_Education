import 'package:firebase_database/firebase_database.dart';
import 'package:pikachu_education/data/data_modal/data_user_modal.dart';

class UpdateUserInfo {
  static Future<void> updateUserInfo(DataUserModal userInfo, String key) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users").child(key);
    await ref.update({
      'name': userInfo.userName,
      'email': userInfo.email,
      'avatarUrl': userInfo.avatarUrl
    });
  }
}
