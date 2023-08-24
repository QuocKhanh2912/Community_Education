import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pikachu_education/data/data_modal/data_user_modal.dart';
import 'package:pikachu_education/pages/authentication/component/dialog_custom.dart';
import 'package:pikachu_education/routes/page_name.dart';

class AuthenticationService {
  static Future<void> firebaseLogout() async {
    await FirebaseAuth.instance.signOut();
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
      Map mapDataUser = {
        'email': userInfo.user?.email,
        'name': userInfo.user?.displayName,
        'avatarUrl': userInfo.user?.photoURL
      };
      userCurrentInfo =
          DataUserModal.fromMap(key: userInfo.user!.uid, map: mapDataUser);
      return userCurrentInfo;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    return userCurrentInfo;
  }


  static Future<bool> firebaseLoginByPhoneNumber(
      {required String phoneNum, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNum,
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            showDialog(
              context: context,
              builder: (context) =>
                  DialogCustom.dialogOfWrongPhoneNumber(context),
            );
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          await Navigator.pushNamed(context, PageName.verifyPage,
              arguments: verificationId);
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }


  static Future<bool> firebaseVerifyOTP(
      {required String verificationId, required String otpNumber}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpNumber);
      await auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }
}
