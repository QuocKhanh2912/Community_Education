import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pikachu_education/pages/authentication/component/dialog_custom.dart';
import 'package:pikachu_education/routes/page_name.dart';

class LoginByNumber {
  static Future<bool> phoneAuthentication(
      String phoneNum, BuildContext context) async {
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

  static Future<bool> verifyOTP(
      String verificationId, String otpNumber, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpNumber);
      await auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => DialogCustom.wrongOTPCode(context),
      );
      return false;
    }
  }
}
