import 'package:flutter/material.dart';
import 'package:pikachu_education/pages/answer_page/component/detail_answer_page/detail_answer_page.dart';
import 'package:pikachu_education/pages/authentication/forgot_password_page/1_get_otp_page.dart';
import 'package:pikachu_education/pages/authentication/forgot_password_page/3_save_new_password_page.dart';
import 'package:pikachu_education/pages/authentication/forgot_password_page/4_success_change_password_page.dart';
import 'package:pikachu_education/pages/authentication/login_page/component/verify_otp_page.dart';
import 'package:pikachu_education/pages/authentication/profile_page/profile_page.dart';
import 'package:pikachu_education/pages/answer_page/list_answer_page.dart';
import 'package:pikachu_education/pages/authentication/change_password_page/change_password_page.dart';
import 'package:pikachu_education/pages/authentication/signup_page/signup_page.dart';
import 'package:pikachu_education/pages/authentication/signup_page/signup_success_page.dart';
import 'package:pikachu_education/pages/home_page/home_page.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/pages/authentication/login_page/login_page.dart';


var generateRoute = (settings) {
  switch (settings.name) {
    case PageName.loginPage:
      {
        return MaterialPageRoute(builder: (context) => const LoginPage());
      }
    case PageName.signupPage:
      {
        return MaterialPageRoute(builder: (context) => const SignupPage());
      }
    case PageName.changePasswordPage:
      {
        return MaterialPageRoute(
            builder: (context) => const ChangePasswordPage());
      }
    case PageName.listAnswerPage:
      {
        var questionInfo = settings.arguments[0];
        var currentUserInfo = settings.arguments[1];
        return MaterialPageRoute(
            builder: (context) => ListAnswerPage(
                questionInfo: questionInfo,
              currentUserInfo: currentUserInfo,
                ));
      }
    case PageName.getOtpPage:
      {
        return MaterialPageRoute(builder: (context) => const GetOTPPage());
      }
    case PageName.verifyPage:
      {
        var verification=settings.arguments??'';
        return MaterialPageRoute(builder: (context) =>  VerifyOTPPage(verification: verification));
      }
    case PageName.saveNewPasswordPage:
      {
        return MaterialPageRoute(
            builder: (context) => const SaveNewPasswordPage());
      }
    case PageName.successChangePasswordPage:
      {
        return MaterialPageRoute(
            builder: (context) => const SuccessChangePasswordPage());
      }
    case PageName.signupSuccessPage:
      {
        return MaterialPageRoute(
            builder: (context) => const SignupSuccessPage());
      }
    case PageName.detailAnswerPage:
      {
        var currentUserInfo=settings.arguments[1];
        var answerInfo = settings.arguments[0];
        var questionInfo = settings.arguments[2];

        return MaterialPageRoute(
            builder: (context) =>  DetailAnswerPage(answerInfo:answerInfo,currentUserInfo: currentUserInfo,questionInfo: questionInfo,));
      }
    case PageName.homePage:
      {
        String userId=settings.arguments;
        return MaterialPageRoute(builder: (context) =>  HomePage(userId: userId,));
      }
    case PageName.profilePage:
      {
        var  currentUserInfo= settings.arguments;
        return MaterialPageRoute(builder: (context) =>  ProfilePage(currentUserInfo: currentUserInfo));
      }
  }
};
