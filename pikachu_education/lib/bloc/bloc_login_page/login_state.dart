part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginSuccessState extends LoginState {
   final String userId;
  LoginSuccessState({required this.userId});
}
class LoginUnSuccessState extends LoginState{}
class AutoLoginSuccessState extends LoginState{
   final String userId;
   AutoLoginSuccessState({required this.userId});
}
class LoginWithGoogleLoadingState extends LoginState {}
class LoginWithGoogleSuccessState extends LoginState {
  final String userId;
  LoginWithGoogleSuccessState({required this.userId});
}