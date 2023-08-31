import 'package:firebase_database/firebase_database.dart';

import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';

class QuestionDatabaseService {

  static Future<List<DataQuestionModal>> fetchDataQuestionFromSever() async {
    List<DataQuestionModal> listDataQuestions = [];
    List<DataUserModal> listDataUsers = [];

    var needSnapShotUser =
    await FirebaseDatabase.instance.ref("users").orderByKey().get();
    var dataUsers = (needSnapShotUser.value ?? {}) as Map;
    dataUsers.forEach((keyUser, value) {
      var user = (dataUsers[keyUser] ?? {}) as Map;
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
    print('okokokokokok $userId');
    await ref.set({
      'timePost': itemToPost.timePost,
      'questionTitle': itemToPost.questionTitle,
      'questionSubject': itemToPost.questionSubject,
      'questionContent': itemToPost.questionContent,
      'numberLike': itemToPost.numberLike,
      'imageUrl': imageUrl,
      'userAvatarUrl': itemToPost.userAvatarUrl,
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
}