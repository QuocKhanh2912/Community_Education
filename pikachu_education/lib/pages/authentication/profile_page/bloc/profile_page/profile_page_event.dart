part of 'profile_page_bloc.dart';

abstract class ProfilePageEvent {}

class FetchProfilePageData extends ProfilePageEvent {
  final String userId;

  FetchProfilePageData(this.userId);
}

class RefreshProfilePage extends ProfilePageEvent {
  final String userId;

  RefreshProfilePage(this.userId);
}

class PostAvatarEvent extends ProfilePageEvent {
  File file;
  String userId;
  String currentImageName;

  PostAvatarEvent(
      {required this.userId,
      required this.file,
      required this.currentImageName});
}

class UpdateProfileEvent extends ProfilePageEvent {
  DataUserModal itemToUpdate;

  UpdateProfileEvent({required this.itemToUpdate});
}
