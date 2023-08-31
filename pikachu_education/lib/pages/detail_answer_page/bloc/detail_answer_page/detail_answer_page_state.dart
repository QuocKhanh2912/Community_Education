part of 'detail_answer_page_bloc.dart';

@immutable
abstract class DetailAnswerPageState {}

class DetailAnswerPageInitial extends DetailAnswerPageState {}
class PostCommentSuccessState extends DetailAnswerPageState{}
class CommentLoadingState extends DetailAnswerPageState{}
class FetchDataCommentSuccessState extends DetailAnswerPageState{
  List<DataCommentModal> listComment;
  FetchDataCommentSuccessState({required this.listComment});
}
class RefreshDataCommentSuccessState extends DetailAnswerPageState{
  List<DataCommentModal> listComment;
  RefreshDataCommentSuccessState({required this.listComment});
}

class EditCommentSuccessState extends DetailAnswerPageState{}
class DeleteCommentSuccessState extends DetailAnswerPageState{}

