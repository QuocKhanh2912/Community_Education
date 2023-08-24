part of 'get_image_to_create_answer_bloc.dart';

@immutable
abstract class GetImageToCreateAnswerState {}

class GetImageToCreateAnswerInitial extends GetImageToCreateAnswerState {}
class GetImageToCreateAnswerSuccess extends GetImageToCreateAnswerState {
  File image;

  GetImageToCreateAnswerSuccess({required this.image});

}
