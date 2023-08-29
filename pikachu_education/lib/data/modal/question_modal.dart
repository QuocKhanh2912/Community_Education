class DataQuestionModal {
  final String userId;
  final String userName;
  final String? userAvatarUrl;
  final String timePost;
  final String questionId;
  final String questionSubject;
  final String questionTitle;
  final String questionContent;
  final int? numberAnswer;
  final Map<dynamic, dynamic>? listDataAnswer;
  final int? numberLike;
  final Map<dynamic, dynamic>? listUserIdLiked;
  final String? imageUrl;


  DataQuestionModal(
      {required this.userId,
      required this.userName,
      required this.timePost,
      required this.questionId,
      required this.questionSubject,
      required this.questionTitle,
      required this.questionContent,
      this.numberAnswer,
      this.listDataAnswer,
      this.numberLike,
      this.listUserIdLiked,
      this.imageUrl,this.userAvatarUrl});

  static DataQuestionModal fromMap(
          {required String key,
          required Map<dynamic, dynamic> map,
          required String userName,
          required String userId,
          required int numberAnswer}) =>
      DataQuestionModal(
          userId: userId,
          userName: userName,
          questionId: key,
          timePost: map['timePost'] ?? '01/01/2023 at 00:00',
          questionSubject: map['questionSubject'] ?? '',
          questionTitle: map['questionTitle'] ?? '',
          questionContent: map['questionContent'] ?? '',
          numberAnswer: numberAnswer,
          listDataAnswer: map['answers'],
          numberLike: map['numberLike'] ?? 0,
          listUserIdLiked: map['listUserIdLiked']??{},
          imageUrl: map['imageUrl'] ?? '',userAvatarUrl: map['userAvatarUrl']??'');

  Map<dynamic, dynamic> toMap() {
    return {
      'questionTitle': questionTitle,
      'questionSubject': questionSubject,
      'questionContent': questionContent
    };
  }
}

// DataQuestionModal mockDataQuestionModalUser1 = DataQuestionModal(
// questionId: '1234',
// subjectQuestion: 'match',
// titleQuestion: 'titleQuestion',
// contentQuestion: 'contentQuestion');
// DataQuestionModal mockDataQuestionModalUser2 = DataQuestionModal(
// questionId: '1234',
// subjectQuestion: 'match',
// titleQuestion: 'titleQuestion',
// contentQuestion: 'contentQuestion');
// DataQuestionModal mockDataQuestionModalUser3 = DataQuestionModal(
// questionId: '1234',
// subjectQuestion: 'match',
// titleQuestion: 'titleQuestion',
// contentQuestion: 'contentQuestion');
// List<DataQuestionModal> listDataQuestion = [
// mockDataQuestionModalUser1,
// mockDataQuestionModalUser1,
// mockDataQuestionModalUser3
// ];
