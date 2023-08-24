import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pikachu_education/data/data_modal/data_answer_modal.dart';
import 'package:pikachu_education/domain/repositories/database_repositories.dart';
import 'package:pikachu_education/domain/services/database_service/database_service_answer.dart';
import 'package:pikachu_education/service/storage_service/storage_service.dart';

part 'list_answer_page_event.dart';

part 'list_answer_page_state.dart';

class ListAnswerPageBloc
    extends Bloc<ListAnswerPageEvent, ListAnswerPageState> {
  ListAnswerPageBloc() : super(ListAnswerPageInitial()) {
    on<PostAnswerEvent>((event, emit) async {
      if(event.file==null){
        await DatabaseRepositories.postDataAnswerToSever(
            itemToPost: event.itemToPost,
            userIdOfQuestion: event.userIdOfQuestion,
            questionId: event.questionId,imageUrl: '');
        emit(PostAnswerSuccessState());
      }
      else{
        var imageUrl = await StorageService.upLoadImageToStorage(file: event.file!);
        await DatabaseRepositories.postDataAnswerToSever(
            itemToPost: event.itemToPost,
            userIdOfQuestion: event.userIdOfQuestion,
            questionId: event.questionId,imageUrl: imageUrl);
        emit(PostAnswerSuccessState());
      }

    });

    on<RefreshDataAnswerListEvent>((event, emit) async {
      var listDataAnswer = await DatabaseRepositories.fetchDataAnswerFromSever(
         userIdOfQuestion:  event.userIdOfQuestion,questionId:  event.questionId);
      emit(FetchListAnswerPageSuccessState(listAnswers: listDataAnswer));
    });

    on<FetchDataAnswerListEvent>((event, emit) async {
      emit(ListAnswerPageLoadingState());
      var listDataAnswer = await DatabaseRepositories.fetchDataAnswerFromSever(questionId:
          event.userIdOfQuestion,userIdOfQuestion:  event.questionId);
      emit(FetchListAnswerPageSuccessState(listAnswers: listDataAnswer));
    });

    on<EditAnswerEvent>((event, emit) async {
      await DatabaseRepositories.editAnswer(
          questionId: event.questionId,
          userIdOfQuestion: event.userIdOfQuestion,
          answerId: event.answerId,
          itemToPost: event.itemToPost);
      emit(EditAnswerSuccessState());
    });

    on<DeleteAnswerEvent>((event, emit) async {
      await DatabaseRepositories.deleteAnswer(
        questionId: event.questionId,
        userIdOfQuestion: event.userIdOfQuestion,
        answerId: event.answerId,
      );
      emit(DeleteAnswerSuccessState());
    });

    on<LikeAnswersEvent>((event, emit) async {
      await DatabaseRepositories.likedAnswer(
          userIdOfQuestion: event.userIdOfQuestion,
          questionId: event.questionId,
          currentUserId: event.currentUserId,answerId: event.answerId);
      emit(LikeAnswerSuccessState());
    });

    on<RemoveLikeAnswersEvent>((event, emit) async {
      await DatabaseRepositories.removedLikeAnswer(
          userIdOfQuestion: event.userIdOfQuestion,
          questionId: event.questionId,
          currentUserId: event.currentUserId,answerId: event.answerId);
      emit(RemoveLikeAnswerSuccessState());
    });
  }
}
