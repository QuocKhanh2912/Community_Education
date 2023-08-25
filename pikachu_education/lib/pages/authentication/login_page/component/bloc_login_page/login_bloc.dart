import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:pikachu_education/domain/repositories/auth_repositories.dart';
import 'package:pikachu_education/domain/repositories/database_repositories.dart';
import 'package:pikachu_education/domain/services/auth_service.dart';
import 'package:pikachu_education/service/service_local_storage/service_save_data_to_local_storage.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginAutoEvent>(_autoLogin);
    on<LoginWithGoogleEvent>(_loginWithGoogle);
    on<LoginWithPhoneNumEvent>(_loginWithPhoneNumEvent);
    on<LoginVerifyOtpEvent>(_verifyOtpEvent);
  }

  _autoLogin(LoginAutoEvent event, Emitter<LoginState> emit) async {
    var checkLogin = await AuthRepositories.firebaseLoginChecked();
    if (checkLogin) {
      var userId = await AuthRepositories.firebaseGetUserId();
      await SaveDataToLocal.saveDataUserId(userId: userId);
      await SaveDataToLocal.saveDataUserName(userId: userId);
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
      DatabaseRepositories.updateUserInfo(
          userInfo: loginWithGoogle, key: loginWithGoogle.userId);
      var userId = await AuthRepositories.firebaseGetUserId();
      await SaveDataToLocal.saveDataUserId(userId: userId);
      await SaveDataToLocal.saveDataUserName(userId: userId);
      emit(LoginWithGoogleSuccessState(userId: userId));
    }
  }

  _loginWithPhoneNumEvent(
      LoginWithPhoneNumEvent event, Emitter<LoginState> emit) async {
    emit(LoginWithPhoneNumLoadingState());
    var loginBynUm = await AuthRepositories.firebaseLoginByPhoneNumber(
        phoneNum: event.phoneNum, context: event.context);
    if (loginBynUm) {
      emit(LoginWithPhoneNumSuccessState());
    }
    else {
      emit(LoginWithPhoneNumUnSuccessState());
    }
  }

  _verifyOtpEvent(LoginVerifyOtpEvent event, Emitter<LoginState> emit) async {
    emit(LoginVerificationOTPLoadingState());

    var verifyOTP = await AuthRepositories.firebaseVerifyOTP(
        verificationId: AuthenticationService.verification??'',
        otpNumber: event.otpNumber);
    if (verifyOTP) {
      var userId = await AuthRepositories.firebaseGetUserId();
      await SaveDataToLocal.saveDataUserId(userId: userId);
      await SaveDataToLocal.saveDataUserName(userId: userId);
      emit(LoginVerificationOTPSuccessState(userId: userId));
    } else {
      emit(LoginVerificationOTPUnSuccessState());
    }
  }
}
