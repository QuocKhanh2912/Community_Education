import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pikachu_education/domain/repositories/database_repositories.dart';
import 'package:pikachu_education/service/storage_service/storage_service.dart';
part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  ProfilePageBloc() : super(ProfilePageInitial()) {
    on<PostAvatarEvent>(_postAvatarEvent);
  }
    _postAvatarEvent(PostAvatarEvent event, Emitter<ProfilePageState> emit) async {
      // await StorageService.deleteImageOnStorage(imageName: event.currentImageName);
      var avatarUrl =
          await StorageService.upLoadImageToStorage(file: event.file);
      await DatabaseRepositories.postUserAvatar(
          avatarUrl: avatarUrl, userId: event.userId);
      emit(PostAvatarSuccess());
    }

}
