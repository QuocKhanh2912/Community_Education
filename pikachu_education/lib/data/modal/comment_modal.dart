class DataCommentModal {
  String userIdPostComment;
  String userNamePostComment;
  String commentId;
  String contentComment;
  String timePost;


  DataCommentModal(
      {required this.contentComment,
      required this.timePost,
      required this.userIdPostComment,
      required this.userNamePostComment,
      required this.commentId});

  static DataCommentModal fromMap({required String key, required Map<dynamic, dynamic> map}) {
    return DataCommentModal(
        commentId: key,
        userNamePostComment: map['userNamePostComment'],
        userIdPostComment: map['userIdPostComment'],
        contentComment: map['contentComment'],
        timePost: map['timePost']);

  }
}
