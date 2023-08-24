part of 'get_image_to_set_avatar_bloc.dart';

@immutable
abstract class GetImageToSetAvatarEvent {}


class GetImageToSetAvatarByGalleyEvent extends GetImageToSetAvatarEvent{
  ImageSource source;
  GetImageToSetAvatarByGalleyEvent({required this.source});
}