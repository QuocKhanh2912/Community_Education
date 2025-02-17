import 'package:flutter/material.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/domain/services/auth_service.dart';

class AuthRepositories {
  final AuthenticationService _service = AuthenticationService();

  static Future<DataUserModal> getCurrentUserInfo({required String userID}) {
    return AuthenticationService.getCurrentUserInfo(userID: userID);
  }

  static Future<void> postUserAvatar(
      {required String avatarUrl, required String userId}) {
    return AuthenticationService.postUserAvatar(avatarUrl: avatarUrl, userId: userId);
  }

  static Future<String> getCurrentUserName({required String currentUserID}) {
    return AuthenticationService.getCurrentUserName(currentUserID: currentUserID);
  }


  //logout
  Future<void>? firebaseLogout() {
    return AuthenticationService.firebaseGoogleLogout();
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
//login by facebook
  static Future<DataUserModal> firebaseLoginByFacebook() {
    return AuthenticationService.firebaseLoginByFacebook();
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
  static Future<DataUserModal> firebaseVerifyOTP(
      {required String verificationId,
      required String otpNumber,}) {
    return AuthenticationService.firebaseVerifyOTP(otpNumber: otpNumber, verificationId: verificationId);
  }
  static Future<void> updateCurrentUserInfo(
      {required DataUserModal itemToUpdate}) {
    return AuthenticationService.updateCurrentUserInfo(itemToUpdate:itemToUpdate);
  }
  static Future<void> updateUserInfoFromGoogle(
      {required DataUserModal userInfo, required String key}) {
    return AuthenticationService.updateUserInfoFromMethodLogin(key: key, userInfo: userInfo);
  }
}
