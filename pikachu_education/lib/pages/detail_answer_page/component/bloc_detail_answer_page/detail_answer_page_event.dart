part of 'detail_answer_page_bloc.dart';

@immutable
abstract class DetailAnswerPageEvent {}

class PostCommentEvent extends DetailAnswerPageEvent {
  String userIdOfQuestion;
  String questionId;
  String answerId;
  DataCommentModal itemToPost;

  PostCommentEvent(
      {required this.userIdOfQuestion,
      required this.questionId,
      required this.itemToPost,
      required this.answerId});
}

class FetchDataCommentEvent extends DetailAnswerPageEvent {
  String userIdOfQuestion;
  String questionId;
  String answerId;

  FetchDataCommentEvent(
      {required this.answerId,
      required this.questionId,
      required this.userIdOfQuestion});
}

class RefreshDataCommentEvent extends DetailAnswerPageEvent {
  String userIdOfQuestion;
  String questionId;
  String answerId;

  RefreshDataCommentEvent(
      {required this.answerId,
      required this.questionId,
      required this.userIdOfQuestion});
}

class EditCommentEvent extends DetailAnswerPageEvent {
  String userIdOfQuestion;
  String questionId;
  String answerId;
  String commentId;
  DataCommentModal itemToPost;

  EditCommentEvent(
      {required this.userIdOfQuestion,
      required this.questionId,
      required this.itemToPost,
      required this.answerId,
      required this.commentId});
}

class DeleteCommentEvent extends DetailAnswerPageEvent {
  String userIdOfQuestion;
  String questionId;
  String answerId;
  String commentId;

  DeleteCommentEvent(
      {required this.userIdOfQuestion,
        required this.questionId,
        required this.answerId,
        required this.commentId});
}

