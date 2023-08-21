import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pikachu_education/service/service_local_storage/service_save_data_to_local_storage.dart';
import 'package:pikachu_education/service/service_login/firebase_login.dart';
import 'package:pikachu_education/service/service_login/firebase_login_by_phone_number.dart';


part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoginPressEvent>((event, emit) async {
      var loginWithEmail =
          await LoginService.login(event.email, event.password, event.context);
      if (loginWithEmail == true) {
        var userId = await LoginService.getUserId();
        await SaveDataToLocal.saveDataUserId(userId: userId);
        await SaveDataToLocal.saveDataUserName(userId: userId);
        emit(LoginSuccessState(userId: userId));
      }
      if (loginWithEmail == false) {
        emit(LoginUnSuccessState());
      }
    });
    on<AutoLogin>((event, emit) async {
      var checkLogin = await LoginService.checkAlreadyLogin();
      if (checkLogin) {
        var userId = await LoginService.getUserId();
        await SaveDataToLocal.saveDataUserId(userId: userId);
        await SaveDataToLocal.saveDataUserName(userId: userId);
        emit(AutoLoginSuccessState(userId: userId));
      } else {
        emit(LoginUnSuccessState());
      }
    });

    on<LoginWithGoogle>((event, emit) async {
      emit(LoginWithGoogleLoadingState());
      var loginWithGoogle = await LoginService.signInWithGoogle();
      if (loginWithGoogle == true) {
        var userId = await LoginService.getUserId();
        await SaveDataToLocal.saveDataUserId(userId: userId);
        await SaveDataToLocal.saveDataUserName(userId: userId);
        emit(LoginWithGoogleSuccessState(userId: userId));
      }
      if (loginWithGoogle == false) {
        emit(LoginUnSuccessState());
      }
    });

    on<LoginWithPhoneNumEvent>((event, emit) async {
      emit(LoginWithPhoneNumLoadingState());
      var loginBynUm = await LoginByNumber.phoneAuthentication(
          event.phoneNum, event.context);
      if (loginBynUm) {
        emit(LoginWithPhoneNumSuccessState());
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(VerifyOTPLoadingState());
      var verifyOTP = await LoginByNumber.verifyOTP(
          event.verificationId, event.otpNumber, event.context);
      if (verifyOTP) {
        var userId = await LoginService.getUserId();
        await SaveDataToLocal.saveDataUserId(userId: userId);
        await SaveDataToLocal.saveDataUserName(userId: userId);
        emit(VerifyOTPSuccessState(userId: userId));
      }
    });
  }
}
