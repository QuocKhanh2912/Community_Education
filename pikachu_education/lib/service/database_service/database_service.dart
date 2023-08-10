import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pikachu_education/data/data_modal/data_answer_modal.dart';
import '../../data/data_modal/data_comment_modal.dart';
import '../../data/data_modal/data_question_modal.dart';
import '../../data/data_modal/data_user_modal.dart';

class DatabaseService {
  static Future<DataUserModal> getCurrentUserInfo(
      {required String userID}) async {
    var currentUserInfoSnapshot =
        await FirebaseDatabase.instance.ref('users/$userID').orderByKey().get();
    var currentUserInfoMap = (currentUserInfoSnapshot.value ?? {}) as Map;
    final DataUserModal currentUserInfo = DataUserModal(
        userId: userID,
        avatarUrl: currentUserInfoMap['avatarUrl']??'',
        userName: currentUserInfoMap['name'] ?? '',
        email: currentUserInfoMap['email'] ?? '');
    return currentUserInfo;
  }

  static Future<void> postUserAvatar(
      {required String avatarUrl,required String userId}) async {
    DatabaseReference ref =
    FirebaseDatabase.instance.ref("users/$userId");
    await ref.update({'avatarUrl':avatarUrl});
  }

  static Future<List<DataQuestionModal>> fetchDataQuestionFromSever() async {
    List<DataQuestionModal> listDataQuestions = [];
    List<DataUserModal> listDataUsers = [];

    var needSnapShotUser =
        await FirebaseDatabase.instance.ref("users").orderByKey().get();
    var dataUsers = (needSnapShotUser.value ?? {}) as Map;
    dataUsers.forEach((keyUser, value) {
      var user = (dataUsers[keyUser] ?? {}) as Map;
      // List<String> listQuestionIdLiked =[];
      // var questionIdLikedMap=(user['listQuestionIdLiked']??{}) as Map;
      // questionIdLikedMap.forEach((key, value) {listQuestionIdLiked.add(value); });
      listDataUsers.add(DataUserModal.fromMap(key: keyUser, map: value));
      var questionList = (user['questions'] ?? {}) as Map;
      questionList.forEach((key, value) {
        var question = (questionList[key] ?? {}) as Map;
        var answers = (question['answers'] ?? {}) as Map;
        listDataQuestions.add(DataQuestionModal.fromMap(
            key: key,
            map: value,
            userName: user['name'],
            userId: keyUser,
            numberAnswer: answers.length));
      });
    });


    return listDataQuestions;
  }

  static Future<void> postDataQuestionToSever(
      {required DataQuestionModal itemToPost, required String userId,required String imageUrl}) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("users/$userId")
        .child('questions')
        .push();
    await ref.set({
      'timePost': itemToPost.timePost,
      'questionTitle': itemToPost.questionTitle,
      'questionSubject': itemToPost.questionSubject,
      'questionContent': itemToPost.questionContent,
      'numberLike': itemToPost.numberLike,
      'imageUrl': imageUrl,
      'userAvatarUrl': itemToPost.userAvatarUrl
    });
  }

  static Future<void> editDataQuestion(
      {required DataQuestionModal itemToPost,
      required String userId,
      required String questionId}) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/$userId/questions/$questionId");
    await ref.update({
      'timePost': itemToPost.timePost,
      'questionTitle': itemToPost.questionTitle,
      'questionSubject': itemToPost.questionSubject,
      'questionContent': itemToPost.questionContent,
    });
  }

  static Future<void> deleteQuestion(
      {required String userIdOfQuestion, required String questionId}) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("users/$userIdOfQuestion/questions/$questionId");
    await ref.remove();
  }

  static Future<List<DataAnswerModal>> fetchDataAnswerFromSever(
      String userIdOfQuestion, String questionId) async {
    List<DataAnswerModal> listDataAnswer = [];
    var needSnapShotUser = await FirebaseDatabase.instance
        .ref("/users/$userIdOfQuestion/questions/$questionId/answers")
        .orderByKey()
        .get();
    var dataAnswers = (needSnapShotUser.value ?? {}) as Map;
    dataAnswers.forEach((key, value) {
      var answer = (dataAnswers['$key'] ?? {}) as Map;
      var comments = (answer['comments'] ?? {}) as Map;
      listDataAnswer.add(DataAnswerModal.fromMap(
          key: key, map: value, numberComment: comments.length));
    });

    return listDataAnswer;
  }

  static Future<void> postDataAnswerToSever(
      {required DataAnswerModal itemToPost,
      required String userIdOfQuestion,
      required String questionId,required String imageUrl}) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("users/$userIdOfQuestion/questions/$questionId")
        .child('answers')
        .push();
    await ref.set({
      'userIdPost': itemToPost.userIdPost,
      'userNamePost': itemToPost.userNamePost,
      'timePost': itemToPost.timePost,
      'answerTitle': itemToPost.answerTitle,
      'answerContent': itemToPost.answerContent,
      'numberLike': itemToPost.numberLike,
      'imageUrl': imageUrl
    });
  }

  static Future<void> editAnswer(
      {required DataAnswerModal itemToPost,
      required String userIdOfQuestion,
      required String questionId,
      required String answerId}) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("users/$userIdOfQuestion/questions/$questionId/answers/$answerId");
    await ref.update({
      'timePost': itemToPost.timePost,
      'answerTitle': itemToPost.answerTitle,
      'answerContent': itemToPost.answerContent,
    });
  }

  static Future<void> deleteAnswer(
      {required String userIdOfQuestion,
      required String questionId,
      required String answerId}) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("users/$userIdOfQuestion/questions/$questionId/answers/$answerId");
    await ref.remove();
  }

  static Future<String> getCurrentUserName(
      {required String currentUserID}) async {
    var currentUserNameSnapshot = await FirebaseDatabase.instance
        .ref("/users/$currentUserID")
        .child('name')
        .get();

    var currentUserName = currentUserNameSnapshot.value as String;
    return currentUserName;
  }

  static Future<void> postDataCommentToSever(
      {required DataCommentModal itemToPost,
      required String userIdOfQuestion,
      required String questionId,
      required String answerId}) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("/users/$userIdOfQuestion/questions/$questionId/answers/$answerId")
        .child('comments')
        .push();
    await ref.set({
      'userIdPostComment': itemToPost.userIdPostComment,
      'userNamePostComment': itemToPost.userNamePostComment,
      'contentComment': itemToPost.contentComment,
      'timePost': itemToPost.timePost,
    });
  }

  static Future<List<DataCommentModal>> fetchDataCommentFromSever(
      {required String userIdOfQuestion,
      required String questionId,
      required String answerId}) async {
    List<DataCommentModal> listDataComment = [];
    var needSnapShotComment = await FirebaseDatabase.instance
        .ref(
            '/users/$userIdOfQuestion/questions/$questionId/answers/$answerId/comments')
        .orderByKey()
        .get();

    var dataComments = (needSnapShotComment.value ?? {}) as Map;
    dataComments.forEach((key, value) {
      listDataComment.add(DataCommentModal.fromMap(key: key, map: value));
    });

    return listDataComment;
  }

  static Future<void> editComment(
      {required DataCommentModal itemToPost,
      required String userIdOfQuestion,
      required String questionId,
      required String answerId,
      required String commentId}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(
        "/users/$userIdOfQuestion/questions/$questionId/answers/$answerId/comments/$commentId");
    await ref.update({
      'contentComment': itemToPost.contentComment,
      'timePost': itemToPost.timePost,
    });
  }

  static Future<void> deleteComment(
      {required String userIdOfQuestion,
      required String questionId,
      required String answerId,
      required String commentId}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(
        "/users/$userIdOfQuestion/questions/$questionId/answers/$answerId/comments/$commentId");
    await ref.remove();
  }

  static Future<List<String>> getListQuestionIdLiked(
      {required String currentUserId}) async {
    List<String> listQuestionIdLiked = [];
    var needSnapShotListQuestionLiked = await FirebaseDatabase.instance
        .ref('/users/$currentUserId/listQuestionIdLiked')
        .orderByKey()
        .get();
    var listQuestionLikedMap = (needSnapShotListQuestionLiked.value ?? {}) as Map;
    listQuestionLikedMap.forEach((key, value) {listQuestionIdLiked.add(value); });
    return listQuestionIdLiked;
  }

  static Future<void> likedQuestion(
      {required String userIdOfQuestion,
      required String questionId,
      required String currentUserId }) async {
    DatabaseReference ref =  FirebaseDatabase.instance
        .ref("/users/$userIdOfQuestion/questions/$questionId")
        .child('listUserIdLiked');
    await ref.update({currentUserId:currentUserId});

    DatabaseReference addListQuestionIdLikeToUserRef = FirebaseDatabase.instance
        .ref("/users/$currentUserId")
        .child('listQuestionIdLiked');
    await addListQuestionIdLikeToUserRef.update({questionId: questionId});

    DatabaseReference increaseQuestionIdLikeToUserRef = FirebaseDatabase.instance
        .ref("/users/$userIdOfQuestion/questions/$questionId");
    await increaseQuestionIdLikeToUserRef.update({'numberLike':ServerValue.increment(1)});


  }

  static Future<void> removedLikeQuestion(
      {required String currentUserId, required String questionId,required String userIdOfQuestion }) async {
    await FirebaseDatabase.instance
        .ref('/users/$currentUserId/listQuestionIdLiked/$questionId').remove();
    await FirebaseDatabase.instance
        .ref('/users/$userIdOfQuestion/questions/$questionId/listUserIdLiked/$currentUserId').remove();
    DatabaseReference increaseQuestionIdLikeToUserRef = FirebaseDatabase.instance
        .ref("/users/$userIdOfQuestion/questions/$questionId");
    await increaseQuestionIdLikeToUserRef.update({'numberLike':ServerValue.increment(-1)});

  }

  static Future<List<String>> getListAnswerIdLiked(
      {required String currentUserId}) async {
    List<String> listAnswerIdLiked = [];
    var needSnapShotListAnswerLiked = await FirebaseDatabase.instance
        .ref('/users/$currentUserId/listAnswerIdLiked')
        .orderByKey()
        .get();
    var listQuestionLikedMap = (needSnapShotListAnswerLiked.value ?? {}) as Map;
    listQuestionLikedMap.forEach((key, value) {listAnswerIdLiked.add(value); });
    return listAnswerIdLiked;
  }

  static Future<void> likedAnswer(
      {required String userIdOfQuestion,
        required String questionId,
        required String answerId,
        required String currentUserId }) async {
    DatabaseReference ref =  FirebaseDatabase.instance
        .ref("/users/$userIdOfQuestion/questions/$questionId/answers/$answerId")
        .child('listUserIdLiked');
    await ref.update({currentUserId:currentUserId});
    DatabaseReference addListAnswerIdLikeToUserRef = FirebaseDatabase.instance
        .ref("/users/$currentUserId")
        .child('listAnswerIdLiked');
    await addListAnswerIdLikeToUserRef.update({answerId: answerId});

    DatabaseReference increaseQuestionIdLikeToUserRef = FirebaseDatabase.instance
        .ref("/users/$userIdOfQuestion/questions/$questionId/answers/$answerId");
    await increaseQuestionIdLikeToUserRef.update({'numberLike':ServerValue.increment(1)});



  }

  static Future<void> removedLikeAnswer(
      {required String currentUserId, required String questionId,required String userIdOfQuestion,required String answerId }) async {
    await FirebaseDatabase.instance
        .ref('/users/$currentUserId/listAnswerIdLiked/$answerId').remove();
    await FirebaseDatabase.instance
        .ref('/users/$userIdOfQuestion/questions/$questionId/answers/$answerId/listUserIdLiked/$currentUserId').remove();
    DatabaseReference increaseQuestionIdLikeToUserRef = FirebaseDatabase.instance
        .ref("/users/$userIdOfQuestion/questions/$questionId/answers/$answerId");
    await increaseQuestionIdLikeToUserRef.update({'numberLike':ServerValue.increment(-1)});
  }
}
