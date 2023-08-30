import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';

class AuthenticationService {
  static Future<void> firebasePhoneNumberLogout() async {
    return FirebaseAuth.instance.signOut();
  }

  static Future<void> firebaseGoogleLogout() async {
    FirebaseAuth.instance.signOut();
    await GoogleSignIn().disconnect();
  }

  static Future<bool> firebaseLoginChecked() async {
    var userId = FirebaseAuth.instance.currentUser;
    if (userId == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<String> firebaseGetUserId() async {
    var currentUserId = FirebaseAuth.instance.currentUser?.uid.toString() ?? '';
    return currentUserId;
  }

  static Future<DataUserModal> firebaseLoginByGoogle() async {
    DataUserModal userCurrentInfo =
        DataUserModal(userId: '', userName: '', email: '');
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      var userInfo =
          await FirebaseAuth.instance.signInWithCredential(credential);
      var checkIsNewUser = userInfo.additionalUserInfo!.isNewUser;
      if (checkIsNewUser) {
        Map mapDataUser = {
          'email': userInfo.user?.email,
          'name': userInfo.user?.displayName,
          'avatarUrl': userInfo.user?.photoURL
        };
        userCurrentInfo =
            DataUserModal.fromMap(key: userInfo.user!.uid, map: mapDataUser);
      } else {
        userCurrentInfo = await AuthenticationService.getCurrentUserInfo(
            userID: userInfo.user!.uid);
      }

      return userCurrentInfo;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    return userCurrentInfo;
  }

  static String? verification;

  static Future<bool> firebaseLoginByPhoneNumber(
      {required String phoneNum}) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNum,
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {}
        },
        codeSent: (String verificationId, int? resendToken) async {
          verification = verificationId;
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static String otpCodeSending({required String verificationId}) {
    return verificationId;
  }

  static bool wrongNumberPhoneWaring() {
    return true;
  }

  static Future<DataUserModal> firebaseVerifyOTP(
      {required String verificationId, required String otpNumber}) async {
    DataUserModal userCurrentInfo =
        DataUserModal(userId: '', userName: '', email: '');
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpNumber);
      var userInfo = await auth.signInWithCredential(credential);
      Map mapDataUser = {
        'phoneNumber': userInfo.user?.phoneNumber,
      };
      userCurrentInfo =
          DataUserModal.fromMap(key: userInfo.user!.uid, map: mapDataUser);

      return userCurrentInfo;
    } catch (e) {
      return userCurrentInfo;
    }
  }

  static Future<void> updateUserInfoFromGoogle(
      {required DataUserModal userInfo, required String key}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users").child(key);
    await ref.update({
      'name': userInfo.userName,
      'email': userInfo.email,
      'avatarUrl': userInfo.avatarUrl
    });
  }

  static Future<void> updateUserInfoFromPhoneNumber(
      {required DataUserModal userInfo, required String key}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users").child(key);
    await ref.update({
      'name': userInfo.userName,
      'email': userInfo.email,
      'avatarUrl': userInfo.avatarUrl,
      'phoneNumber': userInfo.phoneNumber
    });
  }

  static Future<void> updateCurrentUserInfo(
      {required DataUserModal itemToUpdate}) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users").child(itemToUpdate.userId);
    await ref.update({
      'name': itemToUpdate.userName,
      'email': itemToUpdate.email,
      'phoneNumber': itemToUpdate.phoneNumber
    });
  }

  static Future<DataUserModal> getCurrentUserInfo(
      {required String userID}) async {
    var currentUserInfoSnapshot =
        await FirebaseDatabase.instance.ref('users/$userID').orderByKey().get();
    var currentUserInfoMap = (currentUserInfoSnapshot.value ?? {}) as Map;
    final DataUserModal currentUserInfo = DataUserModal(
        userId: userID,
        avatarUrl: currentUserInfoMap['avatarUrl'] ?? '',
        userName: currentUserInfoMap['name'] ?? '',
        email: currentUserInfoMap['email'] ?? '',
        phoneNumber: currentUserInfoMap['phoneNumber'] ?? '');
    return currentUserInfo;
  }

  static Future<void> postUserAvatar(
      {required String avatarUrl, required String userId}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$userId");
    await ref.update({'avatarUrl': avatarUrl});
  }

  static Future<String> getCurrentUserName(
      {required String currentUserID}) async {
    var currentUserNameSnapshot = await FirebaseDatabase.instance
        .ref("/users/$currentUserID")
        .child('name')
        .get();

    var currentUserName = (currentUserNameSnapshot.value ?? '') as String;
    return currentUserName;
  }
}
