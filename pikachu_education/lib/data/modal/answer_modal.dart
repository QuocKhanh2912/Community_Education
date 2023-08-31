class DataAnswerModal {
  final String userIdPost;
  final String userNamePost;
  final String? userAvatarUrl;
  final String timePost;
  final String answerId;
  final String answerTitle;
  final String answerContent;
  final int? numberLike;
  final Map<dynamic, dynamic>? listComment;
  final int? numberComment;
  final String? imageUrl;
  final Map<dynamic, dynamic>? listUserIdLiked;

  DataAnswerModal(
      {required this.userNamePost,
      required this.userIdPost,
      required this.timePost,
      required this.answerId,
      required this.answerTitle,
      required this.answerContent,
      this.listComment,
      this.numberLike,
      this.numberComment,
      this.imageUrl,
      this.listUserIdLiked,this.userAvatarUrl});

  static DataAnswerModal fromMap(
          {required String key,
          required Map<dynamic, dynamic> map,
          required int numberComment}) =>
      DataAnswerModal(
          userNamePost: map['userNamePost'] ?? 'admin',
          answerId: key,
          timePost: map['timePost'] ?? '01/01/2023 at 00:00',
          answerTitle: map['answerTitle'] ?? '',
          answerContent: map['answerContent'] ?? '',
          userIdPost: map['userIdPost'] ?? 'admin',
          numberLike: map['numberLike'] ?? 0,
          listComment: map['listComment'],
          numberComment: numberComment,
          imageUrl: map['imageUrl'] ?? '',
          listUserIdLiked: map['listUserIdLiked'] ?? {},userAvatarUrl: map['userAvatarUrl']??'');
}
