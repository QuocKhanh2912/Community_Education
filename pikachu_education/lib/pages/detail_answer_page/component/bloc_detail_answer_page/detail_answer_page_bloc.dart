
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pikachu_education/data/data_modal/data_comment_modal.dart';
import 'package:pikachu_education/domain/repositories/database_repositories.dart';
import 'package:pikachu_education/domain/services/database_service/databaser_service_comment.dart';
part 'detail_answer_page_event.dart';

part 'detail_answer_page_state.dart';

class DetailAnswerPageBloc
    extends Bloc<DetailAnswerPageEvent, DetailAnswerPageState> {
  DetailAnswerPageBloc() : super(DetailAnswerPageInitial()) {
    on<DetailAnswerPageEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<PostCommentEvent>((event, emit) async {

      await DatabaseRepositories.postDataCommentToSever(
          itemToPost: event.itemToPost,
          userIdOfQuestion: event.userIdOfQuestion,
          questionId: event.questionId,
          answerId: event.answerId);
      emit(PostCommentSuccessState());
    });

    on<FetchDataCommentEvent>((event, emit) async {
      emit(CommentLoadingState());
      var listDataComment = await DatabaseRepositories.fetchDataCommentFromSever(
          userIdOfQuestion: event.userIdOfQuestion,
          questionId: event.questionId,
          answerId: event.answerId);
      emit(FetchDataCommentSuccessState(listComment: listDataComment));
    });

    on<RefreshDataCommentEvent>((event, emit) async {
      var listDataComment = await DatabaseRepositories.fetchDataCommentFromSever(
          userIdOfQuestion: event.userIdOfQuestion,
          questionId: event.questionId,
          answerId: event.answerId);
      emit(FetchDataCommentSuccessState(listComment: listDataComment));
    });

    on<EditCommentEvent>((event, emit) async {
      await DatabaseRepositories.editComment(
          itemToPost: event.itemToPost,
          userIdOfQuestion: event.userIdOfQuestion,
          questionId: event.questionId,
          answerId: event.answerId,
          commentId: event.commentId);
      emit(EditCommentSuccessState());
    });

    on<DeleteCommentEvent>((event, emit) async {
      await DatabaseRepositories.deleteComment(
          userIdOfQuestion: event.userIdOfQuestion,
          questionId: event.questionId,
          answerId: event.answerId,
          commentId: event.commentId);
      emit(DeleteCommentSuccessState());
    });



  }
}
