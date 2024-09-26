import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pikachu_education/domain/repositories/auth_repositories.dart';
import 'package:pikachu_education/domain/services/auth_service.dart';
import 'package:pikachu_education/service/authentication/authentication_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    _authService = AuthenticationLocalService();

    on<LoginAutoEvent>(_autoLogin);
    on<LoginWithGoogleEvent>(_loginWithGoogle);
    on<LoginWithFacebookEvent>(_loginWithFacebookEvent);
    on<LoginWithPhoneNumEvent>(_loginWithPhoneNumEvent);
    on<LoginVerifyOtpEvent>(_verifyOtpEvent);
    on<LogoutEvent>(_logoutEvent);
  }

  late final AuthenticationLocalService _authService;

  _autoLogin(LoginAutoEvent event, Emitter<LoginState> emit) async {
    var checkLogin = await AuthRepositories.firebaseLoginChecked();
    if (checkLogin) {
      var userId = await AuthRepositories.firebaseGetUserId();
      await _authService.saveDataUserId(userId: userId);
      await _authService.saveDataUserName(userId: userId);
      emit(AutoLoginSuccessState(userId: userId));
    } else {
      emit(LoginUnSuccessState());
    }
  }

  _loginWithGoogle(LoginWithGoogleEvent event, Emitter<LoginState> emit) async {
    emit(LoginWithGoogleLoadingState());
    var loginWithGoogle = await AuthRepositories.firebaseLoginByGoogle();
    if (loginWithGoogle.userId.isEmpty) {
      emit(LoginUnSuccessState());
    } else {
      await AuthenticationService.updateUserInfoFromMethodLogin(
          userInfo: loginWithGoogle, key: loginWithGoogle.userId);
      await _authService.saveDataUserId(userId: loginWithGoogle.userId);
      await _authService.saveDataUserName(userId: loginWithGoogle.userId);
      await _authService.saveMethodLogin(methodLogin: 'byGoogle');
      emit(LoginWithGoogleSuccessState(userId: loginWithGoogle.userId));
    }
  }

  _loginWithFacebookEvent(
      LoginWithFacebookEvent event, Emitter<LoginState> emit) async {
    emit(LoginWithFacebookLoadingState());
    var loginWithGoogle = await AuthRepositories.firebaseLoginByFacebook();
    if (loginWithGoogle.userId.isEmpty) {
      emit(LoginUnSuccessState());
    } else {
      await AuthenticationService.updateUserInfoFromMethodLogin(
          userInfo: loginWithGoogle, key: loginWithGoogle.userId);
      await _authService.saveDataUserId(userId: loginWithGoogle.userId);
      await _authService.saveDataUserName(userId: loginWithGoogle.userId);
      await _authService.saveMethodLogin(methodLogin: 'byFacebook');
      emit(LoginWithFacebookSuccessState(userId: loginWithGoogle.userId));
    }
  }

  _loginWithPhoneNumEvent(
      LoginWithPhoneNumEvent event, Emitter<LoginState> emit) async {
    emit(LoginWithPhoneNumLoadingState());
    var loginBynUm = await AuthRepositories.firebaseLoginByPhoneNumber(
        phoneNum: event.phoneNum, context: event.context);
    if (loginBynUm) {
      emit(LoginWithPhoneNumSuccessState());
    } else {
      emit(LoginWithPhoneNumUnSuccessState());
    }
  }

  _verifyOtpEvent(LoginVerifyOtpEvent event, Emitter<LoginState> emit) async {
    emit(LoginVerificationOTPLoadingState());

    var currentUserInfo = await AuthRepositories.firebaseVerifyOTP(
        verificationId: AuthenticationService.verification ?? '',
        otpNumber: event.otpNumber);
    if (currentUserInfo.userId.isNotEmpty) {
      await AuthenticationService.updateUserInfoFromPhoneNumber(
          userInfo: currentUserInfo, key: currentUserInfo.userId);
      await _authService.saveDataUserId(userId: currentUserInfo.userId);
      await _authService.saveDataUserName(userId: currentUserInfo.userId);
      await _authService.saveMethodLogin(methodLogin: 'byPhoneNumber');
      emit(LoginVerificationOTPSuccessState(userId: currentUserInfo.userId));
    } else {
      emit(LoginVerificationOTPUnSuccessState());
    }
  }

  _logoutEvent(LogoutEvent event, Emitter<LoginState> emit) async {
    var methodLogin = await _authService.methodLoginCurrent();

    try {
      if (methodLogin == 'byPhoneNumber') {
        await AuthenticationService.firebasePhoneNumberLogout()
            .then((value) => emit(LogoutSuccessState()));
      }
      else if (methodLogin == 'byGoogle') {
        await AuthenticationService.firebaseGoogleLogout()
            .then((value) => emit(LogoutSuccessState()));
      }
      else if (methodLogin == 'byFacebook') {
        await AuthenticationService.firebaseFacebookLogout()
            .then((value) => emit(LogoutSuccessState()));
      }
      else if(methodLogin == ''){
        await AuthenticationService.firebasePhoneNumberLogout()
            .then((value) => emit(LogoutSuccessState()));
      }
    } catch (e) {
      emit(LogoutUnSuccessState());
    }
  }
}
