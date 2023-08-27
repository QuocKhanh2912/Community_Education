import 'package:pikachu_education/data/data_modal/data_answer_modal.dart';
import 'package:pikachu_education/data/data_modal/data_comment_modal.dart';
import 'package:pikachu_education/data/data_modal/data_question_modal.dart';
import 'package:pikachu_education/data/data_modal/data_user_modal.dart';
import 'package:pikachu_education/domain/services/database_realtime_service/database_service.dart';
import 'package:pikachu_education/domain/services/database_realtime_service/database_service_answer.dart';
import 'package:pikachu_education/domain/services/database_realtime_service/database_service_question.dart';
import 'package:pikachu_education/domain/services/database_realtime_service/database_service_update_userinfo.dart';
import 'package:pikachu_education/domain/services/database_realtime_service/databaser_service_comment.dart';

class DatabaseRepositories {
  static Future<DataUserModal> getCurrentUserInfo({required String userID}) {
    return DatabaseService.getCurrentUserInfo(userID: userID);
  }

  static Future<void> postUserAvatar(
      {required String avatarUrl, required String userId}) {
    return DatabaseService.postUserAvatar(avatarUrl: avatarUrl, userId: userId);
  }

  static Future<String> getCurrentUserName({required String currentUserID}) {
    return DatabaseService.getCurrentUserName(currentUserID: currentUserID);
  }

// Database answer
  static Future<List<DataAnswerModal>> fetchDataAnswerFromSever(
      {required String userIdOfQuestion, required String questionId}) {
    return AnswerDatabaseService.fetchDataAnswerFromSever(
        userIdOfQuestion: userIdOfQuestion, questionId: questionId);
  }

  static Future<void> postDataAnswerToSever(
      {required DataAnswerModal itemToPost,
      required String userIdOfQuestion,
      required String questionId,
      required String imageUrl}) {
    return AnswerDatabaseService.postDataAnswerToSever(
        userIdOfQuestion: userIdOfQuestion,
        questionId: questionId,
        imageUrl: imageUrl,
        itemToPost: itemToPost);
  }

  static Future<void> editAnswer(
      {required DataAnswerModal itemToPost,
      required String userIdOfQuestion,
      required String questionId,
      required String answerId}) {
    return AnswerDatabaseService.editAnswer(
        itemToPost: itemToPost,
        questionId: questionId,
        userIdOfQuestion: userIdOfQuestion,
        answerId: answerId);
  }

  static Future<void> deleteAnswer(
      {required String userIdOfQuestion,
      required String questionId,
      required String answerId}) {
    return AnswerDatabaseService.deleteAnswer(
        answerId: answerId,
        userIdOfQuestion: userIdOfQuestion,
        questionId: questionId);
  }

  static Future<List<String>> getListAnswerIdLiked(
      {required String currentUserId}) {
    return AnswerDatabaseService.getListAnswerIdLiked(
        currentUserId: currentUserId);
  }

  static Future<void> likedAnswer(
      {required String userIdOfQuestion,
      required String questionId,
      required String answerId,
      required String currentUserId}) {
    return AnswerDatabaseService.likedAnswer(
        currentUserId: currentUserId,
        userIdOfQuestion: userIdOfQuestion,
        answerId: answerId,
        questionId: questionId);
  }

  static Future<void> removedLikeAnswer(
      {required String currentUserId,
      required String questionId,
      required String userIdOfQuestion,
      required String answerId}) {
    return AnswerDatabaseService.removedLikeAnswer(
        questionId: questionId,
        answerId: answerId,
        userIdOfQuestion: userIdOfQuestion,
        currentUserId: currentUserId);
  }

  static Future<List<String>> getListUserIdLikedAnswer(
      {required String questionId,
      required String userIdOfQuestion,
      required String answerId}) {
    return AnswerDatabaseService.getListUserIdLikedAnswer(
        userIdOfQuestion: userIdOfQuestion,
        answerId: answerId,
        questionId: questionId);
  }

// Database question

  static Future<List<DataQuestionModal>> fetchDataQuestionFromSever() {
    return QuestionDatabaseService.fetchDataQuestionFromSever();
  }

  static Future<void> postDataQuestionToSever(
      {required DataQuestionModal itemToPost,
      required String userId,
      required String imageUrl}) {
    return QuestionDatabaseService.postDataQuestionToSever(
        itemToPost: itemToPost, imageUrl: imageUrl, userId: userId);
  }

  static Future<void> editDataQuestion(
      {required DataQuestionModal itemToPost,
      required String userId,
      required String questionId}) {
    return QuestionDatabaseService.editDataQuestion(
        userId: userId, itemToPost: itemToPost, questionId: questionId);
  }

  static Future<void> deleteQuestion(
      {required String userIdOfQuestion, required String questionId}) {
    return QuestionDatabaseService.deleteQuestion(
        questionId: questionId, userIdOfQuestion: userIdOfQuestion);
  }

  static Future<List<String>> getListQuestionIdLiked(
      {required String currentUserId}) {
    return QuestionDatabaseService.getListQuestionIdLiked(
        currentUserId: currentUserId);
  }

  static Future<void> likedQuestion(
      {required String userIdOfQuestion,
      required String questionId,
      required String currentUserId}) {
    return QuestionDatabaseService.likedQuestion(
      currentUserId: currentUserId,
      questionId: questionId,
      userIdOfQuestion: userIdOfQuestion,
    );
  }

  static Future<void> removedLikeQuestion(
      {required String currentUserId,
      required String questionId,
      required String userIdOfQuestion}) {
    return QuestionDatabaseService.removedLikeQuestion(
      currentUserId: currentUserId,
      questionId: questionId,
      userIdOfQuestion: userIdOfQuestion,
    );
  }

  // Database comment
  static Future<void> postDataCommentToSever(
      {required DataCommentModal itemToPost,
      required String userIdOfQuestion,
      required String questionId,
      required String answerId}) {
    return CommentDatabaseService.postDataCommentToSever(
        userIdOfQuestion: userIdOfQuestion,
        questionId: questionId,
        itemToPost: itemToPost,
        answerId: answerId);
  }

  static Future<List<DataCommentModal>> fetchDataCommentFromSever(
      {required String userIdOfQuestion,
      required String questionId,
      required String answerId}) {
    return CommentDatabaseService.fetchDataCommentFromSever(
        userIdOfQuestion: userIdOfQuestion,
        questionId: questionId,
        answerId: answerId);
  }

  static Future<void> editComment(
      {required DataCommentModal itemToPost,
      required String userIdOfQuestion,
      required String questionId,
      required String answerId,
      required String commentId}) {
    return CommentDatabaseService.editComment(
        commentId: commentId,
        userIdOfQuestion: userIdOfQuestion,
        questionId: questionId,
        itemToPost: itemToPost,
        answerId: answerId);
  }

  static Future<void> deleteComment(
      {required String userIdOfQuestion,
        required String questionId,
        required String answerId,
        required String commentId}) {
    return CommentDatabaseService.deleteComment(
        commentId: commentId,
        userIdOfQuestion: userIdOfQuestion,
        questionId: questionId,
        answerId: answerId);
  }

  //update UserInfo
  static Future<void> updateUserInfo(
      {required DataUserModal userInfo, required String key}) {
    return UpdateUserInfo.updateUserInfo(key: key, userInfo: userInfo);
  }
}
