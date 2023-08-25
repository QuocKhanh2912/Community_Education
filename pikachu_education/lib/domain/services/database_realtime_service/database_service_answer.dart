import 'package:firebase_database/firebase_database.dart';
import 'package:pikachu_education/data/data_modal/data_answer_modal.dart';

class AnswerDatabaseService{
  static Future<List<DataAnswerModal>> fetchDataAnswerFromSever(
      {required String userIdOfQuestion, required String questionId}) async {
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
      'imageUrl': imageUrl,
      'userAvatarUrl':itemToPost.userAvatarUrl,
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


  static Future<List<String>> getListUserIdLikedAnswer(
      {required String questionId,required String userIdOfQuestion,required String answerId }) async {
    List<String> listUserIdLikedAnswer = [];
    var needSnapShotListUserIdLiked = await FirebaseDatabase.instance
        .ref('/users/$userIdOfQuestion/questions/$questionId/answers/$answerId/listUserIdLiked')
        .orderByKey()
        .get();
    var listQuestionLikedMap = (needSnapShotListUserIdLiked.value ?? {}) as Map;
    listQuestionLikedMap.forEach((key, value) {listUserIdLikedAnswer.add(value); });
    return listUserIdLikedAnswer;
  }
}