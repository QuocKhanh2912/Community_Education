import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../pages/authentication/component/dialog_custom.dart';

class Signup {
  static Future<bool> signup(
      String name, String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) =>
              createUser(name: name, email: email, userId: user.user!.uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) => DialogCustom.dialogOfEmailUseAlready(context),
        );
      }
      return false;
    }
    return true;
  }
  static createUser(
      {required String userId, required String name, required String email}) {
    var user = {'name': name, 'email': email};
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');
    ref.child(userId).set(user).then((user) {});
  }
}
