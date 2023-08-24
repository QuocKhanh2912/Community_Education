part of 'get_image_bloc.dart';

@immutable
abstract class GetImageEvent {}
class GetImageByGalley extends GetImageEvent {
  ImageSource source;
  GetImageByGalley({required this.source});
}