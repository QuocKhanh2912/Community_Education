part of 'get_image_to_set_avatar_bloc.dart';

@immutable
abstract class GetImageToSetAvatarState {}

class GetImageToSetAvatarInitial extends GetImageToSetAvatarState {}
class GetImageToCreateAnswerSuccess extends GetImageToSetAvatarState {
  File image;

  GetImageToCreateAnswerSuccess({required this.image});

}