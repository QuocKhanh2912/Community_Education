part of 'profile_page_bloc.dart';


abstract class ProfilePageState {}
class ProfilePageInitial extends ProfilePageState {}

class FetchProfileInfoLoadingState extends ProfilePageState {}
class FetchProfileInfoSuccessState extends ProfilePageState {
  final DataUserModal currentUserInfo;
  FetchProfileInfoSuccessState({required this.currentUserInfo});
}
class FetchProfileInfoUnSuccessState extends ProfilePageState {}

class PostAvatarSuccess extends ProfilePageState {}

class UpdateProfileLoadingState extends ProfilePageState {}
class UpdateProfileSuccessState extends ProfilePageState {}
class UpdateProfileUnSuccessState extends ProfilePageState {}

class GetMethodLoginSuccessState extends ProfilePageState {
  String methodLogin;
  GetMethodLoginSuccessState({required this.methodLogin});
}
