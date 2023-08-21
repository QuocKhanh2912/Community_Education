part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class LoginPressEvent extends LoginEvent{
  final String email;
  final String password;
  final BuildContext context;
  LoginPressEvent({required this.email, required this.password,required this.context});
}

class CheckLogin extends LoginEvent{
  String token;
  CheckLogin({required this.token});

}

class AutoLogin extends LoginEvent{}
class LoginWithGoogle  extends LoginEvent{}

class LoginWithPhoneNumEvent extends LoginEvent{
  String phoneNum;
  final BuildContext context;
  LoginWithPhoneNumEvent({required this.phoneNum,required this.context});
}

class VerifyOtpEvent extends LoginEvent{
  String verificationId;
  String otpNumber;
  final BuildContext context;
  VerifyOtpEvent({required this.otpNumber,required this.context,required this.verificationId});
}