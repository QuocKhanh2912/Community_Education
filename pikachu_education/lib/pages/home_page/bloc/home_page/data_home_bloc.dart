import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/domain/repositories/auth_repositories.dart';
import 'package:pikachu_education/domain/repositories/database_repositories.dart';
import 'package:pikachu_education/domain/services/database_storage_service/storage_service.dart';

part 'data_home_event.dart';
part 'data_home_state.dart';

class DataHomePageBloc extends Bloc<DataHomePageEvent, DataHomePageState> {
  DataHomePageBloc() : super(DataHomePageInitial(const <DataQuestionModal>[])) {
    on<FetchDataQuestionEvent>((event, emit) async {
      emit(FetchDataQuestionLoadingState(const []));
      var listDataUsers =
          await DatabaseRepositories.fetchDataQuestionFromSever();
      emit(FetchDataQuestionSuccessState(listDataUsers));
    });

    on<GetCurrentUserInfoEvent>((event, emit) async {
      var currentUserInfo =
          await AuthRepositories.getCurrentUserInfo(userID: event.userId);
      emit(GetCurrentUserSuccessState(currentUserInfo: currentUserInfo));
    });

    on<RefreshDataQuestion>((event, emit) async {
      var listDataUsers =
          await DatabaseRepositories.fetchDataQuestionFromSever();
      emit(FetchDataQuestionSuccessState(listDataUsers));
    });

    on<PostDataQuestionsEvent>((event, emit) async {
      if (event.file == null) {
        await DatabaseRepositories.postDataQuestionToSever(
            itemToPost: event.dataToPost, userId: event.userId, imageUrl: '');
        emit(PostDataQuestionSuccessState());
      } else {
        var imageUrl =
            await StorageService.upLoadImageToStorage(file: event.file!);
        await DatabaseRepositories.postDataQuestionToSever(
            itemToPost: event.dataToPost,
            userId: event.userId,
            imageUrl: imageUrl);

        emit(PostDataQuestionSuccessState());
      }
    });

    on<EditQuestionsEvent>((event, emit) async {
      await DatabaseRepositories.editDataQuestion(
          itemToPost: event.dataToPost,
          userId: event.userIdOfQuestion,
          questionId: event.questionId);
      emit(EditQuestionSuccessState());
    });
    on<DeleteQuestionsEvent>((event, emit) async {
      await DatabaseRepositories.deleteQuestion(
          userIdOfQuestion: event.userIdOfQuestion,
          questionId: event.questionId);
      emit(DeleteQuestionSuccessState());
    });

    on<LikeQuestionsEvent>((event, emit) async {
      await DatabaseRepositories.likedQuestion(
          userIdOfQuestion: event.userIdOfQuestion,
          questionId: event.questionId,
          currentUserId: event.currentUserId);
      emit(LikedQuestionSuccessState());
    });

    on<RemoveLikeQuestionsEvent>((event, emit) async {
      await DatabaseRepositories.removedLikeQuestion(
          userIdOfQuestion: event.userIdOfQuestion,
          questionId: event.questionId,
          currentUserId: event.currentUserId);
      emit(RemovedLikeQuestionSuccessState());
    });

    on<SearchQuestionEvent>((event, emit) async {
      emit(FetchDataQuestionLoadingState(const []));
      var listDataUsers =
          await DatabaseRepositories.fetchDataQuestionFromSever();
      List<DataQuestionModal> listDataQuestionSearched = [];
      String characterToSearch = event.characterToSearch;
      for (var item in listDataUsers) {
        if (item.questionContent
            .toLowerCase()
            .contains(characterToSearch.toLowerCase())) {
          listDataQuestionSearched.add(item);
        }
      }
      emit(SearchQuestionSuccessState(
          listQuestionSearched: listDataQuestionSearched));
    });
  }
}
