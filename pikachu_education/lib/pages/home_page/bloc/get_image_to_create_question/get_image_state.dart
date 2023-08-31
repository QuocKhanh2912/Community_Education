part of 'get_image_bloc.dart';

@immutable
abstract class GetImageState {}

class GetImageInitial extends GetImageState {}

class GetImageSuccess extends GetImageState {
 File image;

 GetImageSuccess({required this.image});
}
