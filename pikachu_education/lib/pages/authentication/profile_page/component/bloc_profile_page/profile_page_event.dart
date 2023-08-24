part of 'profile_page_bloc.dart';

@immutable
abstract class ProfilePageEvent {}

class PostAvatarEvent extends ProfilePageEvent{
  File file;
  String userId;
  String currentImageName;
  PostAvatarEvent({required this.userId,required this.file,required this.currentImageName});
}
