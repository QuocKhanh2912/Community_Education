import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pikachu_education/data/data_modal/data_user_modal.dart';
import 'package:pikachu_education/pages/authentication/component/dialog_custom.dart';


class LoginService {


  static Future<bool> login(String email, String password,
      BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(e.code);
        showDialog(
          context: context,
          builder: (context) => DialogCustom.dialogOfInvalidEmail(context),
        );
      }
      if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) => DialogCustom.dialogOfWrongPassword(context),
        );
      }
      return false;
    }
    return true;
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().disconnect();
  }


  static Future<bool> checkAlreadyLogin() async {
    var userId = FirebaseAuth.instance.currentUser;
    if (userId == null) {
      return false;
    }
    else {
      return true;
    }
  }

  static Future<String> getUserId() async {
    var currentUserId =
        FirebaseAuth.instance.currentUser?.uid.toString() ?? '';
    return currentUserId;
  }
  static Future<DataUserModal> signInWithGoogle() async {
    DataUserModal userCurrentInfo=DataUserModal(userId: '', userName: '', email: '');
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser
          ?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      var userInfo = await FirebaseAuth.instance.signInWithCredential(
          credential);
      Map mapDataUser = {
        'email': userInfo.user?.email,
        'name': userInfo.user?.displayName,
        'avatarUrl': userInfo.user?.photoURL
      };
      userCurrentInfo = DataUserModal.fromMap(key: userInfo.user!.uid, map: mapDataUser);
      return userCurrentInfo;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    return userCurrentInfo;
  }
}
