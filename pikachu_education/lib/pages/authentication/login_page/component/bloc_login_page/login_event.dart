part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginCheckedEvent extends LoginEvent {
  String token;

  LoginCheckedEvent({required this.token});
}

class LoginAutoEvent extends LoginEvent {}

class LoginWithGoogleEvent extends LoginEvent {}

class LoginWithPhoneNumEvent extends LoginEvent {
  String phoneNum;
  final BuildContext context;

  LoginWithPhoneNumEvent({required this.phoneNum, required this.context});
}

class LoginVerifyOtpEvent extends LoginEvent {
  String otpNumber;

  LoginVerifyOtpEvent({
    required this.otpNumber,
  });
}

class LogoutEvent extends LoginEvent {}
