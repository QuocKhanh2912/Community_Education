part of 'list_answer_page_bloc.dart';


abstract class ListAnswerPageEvent {}

class FetchDataAnswerListEvent extends ListAnswerPageEvent {
  String userIdOfQuestion;
  String questionId;

  FetchDataAnswerListEvent(
      {required this.userIdOfQuestion, required this.questionId});
}

class RefreshDataAnswerListEvent extends ListAnswerPageEvent {
  String userIdOfQuestion;
  String questionId;

  RefreshDataAnswerListEvent(
      {required this.userIdOfQuestion, required this.questionId});
}

class PostAnswerEvent extends ListAnswerPageEvent {
  String userIdOfQuestion;
  String questionId;
  DataAnswerModal itemToPost;
  File? file;

  PostAnswerEvent(
      {required this.userIdOfQuestion,
      required this.questionId,
      required this.itemToPost,
      required this.file});
}

class EditAnswerEvent extends ListAnswerPageEvent {
  String userIdOfQuestion;
  String answerId;
  String questionId;
  DataAnswerModal itemToPost;

  EditAnswerEvent(
      {required this.userIdOfQuestion,
      required this.questionId,
      required this.itemToPost,
      required this.answerId});
}

class DeleteAnswerEvent extends ListAnswerPageEvent {
  String userIdOfQuestion;
  String answerId;
  String questionId;

  DeleteAnswerEvent(
      {required this.userIdOfQuestion,
      required this.questionId,
      required this.answerId});
}

class LikeAnswersEvent extends ListAnswerPageEvent {
  String userIdOfQuestion;
  String questionId;
  String currentUserId;
  String answerId;

  LikeAnswersEvent(
      {required this.userIdOfQuestion,
      required this.questionId,
      required this.currentUserId,
      required this.answerId});
}

class RemoveLikeAnswersEvent extends ListAnswerPageEvent {
  String userIdOfQuestion;
  String questionId;
  String currentUserId;
  String answerId;

  RemoveLikeAnswersEvent(
      {required this.userIdOfQuestion,
      required this.questionId,
      required this.currentUserId,
      required this.answerId});
}
