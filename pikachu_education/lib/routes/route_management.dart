import 'package:flutter/material.dart';
import 'package:pikachu_education/pages/answer_page.dart';
import 'package:pikachu_education/pages/change_password_page.dart';
import 'package:pikachu_education/pages/forgot_password_page/1_get_otp_page.dart';
import 'package:pikachu_education/pages/forgot_password_page/2_verify_page.dart';
import 'package:pikachu_education/pages/forgot_password_page/3_save_new_password_page.dart';
import 'package:pikachu_education/pages/forgot_password_page/4_success_change+password_page.dart';
import 'package:pikachu_education/pages/signup_page/signup_page.dart';
import 'package:pikachu_education/pages/signup_page/signup_success_page.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/pages/login_page.dart';

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
    case PageName.answerPage:
      {
        return MaterialPageRoute(builder: (context) => const AnswerPage());
      }
    case PageName.getOtpPage:
      {
        return MaterialPageRoute(builder: (context) => const GetOTPPage());
      }
    case PageName.verifyPage:
      {
        return MaterialPageRoute(builder: (context) => const VerifyPage());
      }
    case PageName.saveNewPasswordPage:
      {
        return MaterialPageRoute(builder: (context) => const SaveNewPasswordPage());
      }
    case PageName.successChangePasswordPage:
      {
        return MaterialPageRoute(builder: (context) => const SuccessChangePasswordPage());
      }
    case PageName.signupSuccessPage:
      {
        return MaterialPageRoute(builder: (context) => const SignupSuccessPage());
      }
  }
};
