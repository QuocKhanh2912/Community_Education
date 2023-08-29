part of 'list_answer_page_bloc.dart';

abstract class ListAnswerPageState {}

class ListAnswerPageInitial extends ListAnswerPageState {}
class ListAnswerPageLoadingState extends ListAnswerPageState {}
class FetchListAnswerPageSuccessState extends ListAnswerPageState {
  List<DataAnswerModal> listAnswers;
  FetchListAnswerPageSuccessState({required this.listAnswers});
}
class  PostAnswerSuccessState extends ListAnswerPageState {}
class  EditAnswerSuccessState extends ListAnswerPageState {}
class  DeleteAnswerSuccessState extends ListAnswerPageState {}
class  LikeAnswerSuccessState extends ListAnswerPageState {}
class  RemoveLikeAnswerSuccessState extends ListAnswerPageState {}


