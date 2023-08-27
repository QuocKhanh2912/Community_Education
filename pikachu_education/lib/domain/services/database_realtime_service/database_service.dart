import 'package:firebase_database/firebase_database.dart';
import 'package:pikachu_education/data/data_modal/data_user_modal.dart';


class DatabaseService {
  static Future<DataUserModal> getCurrentUserInfo(
      {required String userID}) async {
    var currentUserInfoSnapshot =
        await FirebaseDatabase.instance.ref('users/$userID').orderByKey().get();
    var currentUserInfoMap = (currentUserInfoSnapshot.value ?? {}) as Map;
    final DataUserModal currentUserInfo = DataUserModal(
        userId: userID,
        avatarUrl: currentUserInfoMap['avatarUrl']??'',
        userName: currentUserInfoMap['name'] ?? '',
        email: currentUserInfoMap['email'] ?? '');
    return currentUserInfo;
  }

  static Future<void> postUserAvatar(
      {required String avatarUrl,required String userId}) async {
    DatabaseReference ref =
    FirebaseDatabase.instance.ref("users/$userId");
    await ref.update({'avatarUrl':avatarUrl});
  }

  static Future<String> getCurrentUserName(
      {required String currentUserID}) async {
    var currentUserNameSnapshot = await FirebaseDatabase.instance
        .ref("/users/$currentUserID")
        .child('name')
        .get();

    var currentUserName = (currentUserNameSnapshot.value??'') as String;
    return currentUserName;
  }

}
