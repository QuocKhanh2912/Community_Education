import 'package:firebase_database/firebase_database.dart';
import 'package:pikachu_education/data/data_modal/data_comment_modal.dart';

class CommentDatabaseService{

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
}