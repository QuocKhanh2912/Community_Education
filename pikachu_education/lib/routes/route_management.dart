import 'package:flutter/material.dart';
import 'package:pikachu_education/pages/authentication/login_page/component/verify_otp_page.dart';
import 'package:pikachu_education/pages/authentication/profile_page/profile_page.dart';
import 'package:pikachu_education/pages/answer_page/list_answer_page.dart';
import 'package:pikachu_education/pages/detail_answer_page/detail_answer_page.dart';
import 'package:pikachu_education/pages/home_page/home_page.dart';
import 'package:pikachu_education/pages/on_boarding_page/on_boarding_page.dart';
import 'package:pikachu_education/pages/splash_page/splash_page.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/pages/authentication/login_page/login_page.dart';

var generateRoute = (settings) {
  switch (settings.name) {
    case PageName.splashPage:
      {
        return MaterialPageRoute(builder: (context) => const SplashPage());
      }
    case PageName.onBoardingPage:
      {
        return MaterialPageRoute(builder: (context) => const OnBoardingPage1());
      }

    case PageName.loginPage:
      {
        return MaterialPageRoute(builder: (context) => const LoginPage());
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

    case PageName.verifyPage:
      {

        return MaterialPageRoute(
            builder: (context) => VerifyOTPPage());
      }
    case PageName.detailAnswerPage:
      {
        var currentUserInfo = settings.arguments[1];
        var answerInfo = settings.arguments[0];
        var questionInfo = settings.arguments[2];

        return MaterialPageRoute(
            builder: (context) => DetailAnswerPage(
                  answerInfo: answerInfo,
                  currentUserInfo: currentUserInfo,
                  questionInfo: questionInfo,
                ));
      }
    case PageName.homePage:
      {
        String userId = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => HomePage(
                  userId: userId,
                ));
      }
    case PageName.profilePage:
      {
        var currentUserInfo = settings.arguments;
        return MaterialPageRoute(
            builder: (context) =>
                ProfilePage(currentUserInfo: currentUserInfo));
      }
  }
};
