import 'package:flutter/material.dart';
import 'package:pikachu_education/data/data_modal/data_user_modal.dart';
import 'package:pikachu_education/domain/services/auth_service.dart';

class AuthRepositories {
  final AuthenticationService _service = AuthenticationService();

  //logout
  Future<void>? firebaseLogout() {
    return AuthenticationService.firebaseLogout();
  }

  // check login already or not
  static Future<bool> firebaseLoginChecked() {
    return AuthenticationService.firebaseLoginChecked();
  }

  // get userId after login to transmit to other page
  static Future<String> firebaseGetUserId() {
    return AuthenticationService.firebaseGetUserId();
  }

// login by google
  static Future<DataUserModal> firebaseLoginByGoogle() {
    return AuthenticationService.firebaseLoginByGoogle();
  }

// login by phoneNumber
  static Future<bool> firebaseLoginByPhoneNumber(
      {required String phoneNum, required BuildContext context}) {
    return AuthenticationService.firebaseLoginByPhoneNumber(phoneNum: phoneNum);
  }

  static String otpCodeSending(
      {required String verificationId}) {
    return AuthenticationService.otpCodeSending(verificationId: verificationId);
  }

  static bool wrongNumberPhoneWaring(
      {required String verificationId}) {
    return AuthenticationService.wrongNumberPhoneWaring();
  }

// verify otp code
  static Future<bool> firebaseVerifyOTP(
      {required String verificationId,
      required String otpNumber,}) {
    return AuthenticationService.firebaseVerifyOTP(otpNumber: otpNumber, verificationId: verificationId);
  }
}
