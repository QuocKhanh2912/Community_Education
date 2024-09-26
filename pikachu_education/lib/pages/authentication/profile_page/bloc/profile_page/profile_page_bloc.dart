import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/domain/repositories/auth_repositories.dart';
import 'package:pikachu_education/domain/services/database_storage_service/storage_service.dart';
import 'package:pikachu_education/service/authentication/authentication_service.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  ProfilePageBloc() : super(ProfilePageInitial()) {
    _authService = AuthenticationLocalService();

    on<PostAvatarEvent>(_postAvatarEvent);
    on<UpdateProfileEvent>(_updateProfileEvent);
    on<FetchProfilePageData>(_fetchProfilePageData);
    on<RefreshProfilePage>(_refreshProfilePage);
    on<GetMethodLogin>(_getMethodLogin);
  }

  late final AuthenticationLocalService _authService;

  _postAvatarEvent(
      PostAvatarEvent event, Emitter<ProfilePageState> emit) async {
    var avatarUrl = await StorageService.upLoadImageToStorage(file: event.file);
    await AuthRepositories.postUserAvatar(
        avatarUrl: avatarUrl, userId: event.userId);
    emit(PostAvatarSuccess());
  }

  _updateProfileEvent(
      UpdateProfileEvent event, Emitter<ProfilePageState> emit) async {
    try {
      emit(UpdateProfileLoadingState());
      await AuthRepositories.updateCurrentUserInfo(
          itemToUpdate: event.itemToUpdate);
      emit(UpdateProfileSuccessState());
    } catch (e) {
      emit(UpdateProfileLoadingState());
      emit(UpdateProfileUnSuccessState());
    }
  }

  _fetchProfilePageData(
      FetchProfilePageData event, Emitter<ProfilePageState> emit) async {
    try {
      emit(FetchProfileInfoLoadingState());
      var currentUserInfo =
          await AuthRepositories.getCurrentUserInfo(userID: event.userId);
      emit(FetchProfileInfoSuccessState(currentUserInfo: currentUserInfo));
    } catch (e) {
      emit(FetchProfileInfoLoadingState());
      emit(FetchProfileInfoUnSuccessState());
    }
  }

  _refreshProfilePage(
      RefreshProfilePage event, Emitter<ProfilePageState> emit) async {
    try {
      var currentUserInfo =
          await AuthRepositories.getCurrentUserInfo(userID: event.userId);
      emit(FetchProfileInfoSuccessState(currentUserInfo: currentUserInfo));
    } catch (e) {
      emit(FetchProfileInfoUnSuccessState());
    }
  }

  _getMethodLogin(GetMethodLogin event, Emitter<ProfilePageState> emit) async {
    var methodLogin = await _authService.methodLoginCurrent();
    emit(GetMethodLoginSuccessState(methodLogin: methodLogin));
  }
}
