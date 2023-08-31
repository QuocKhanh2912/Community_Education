part of 'get_image_to_create_answer_bloc.dart';

@immutable
abstract class GetImageToCreateAnswerEvent {}

class GetImageToCreateAnswerByGalleyEvent extends GetImageToCreateAnswerEvent{
  ImageSource source;
  GetImageToCreateAnswerByGalleyEvent({required this.source});
}