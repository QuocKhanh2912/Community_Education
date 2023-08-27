import 'package:flutter/material.dart';
import 'package:pikachu_education/data/data_modal/data_answer_modal.dart';
import 'package:pikachu_education/data/data_modal/data_comment_modal.dart';
import 'package:pikachu_education/data/data_modal/data_question_modal.dart';
import 'package:pikachu_education/pages/detail_answer_page/component/bloc_detail_answer_page/detail_answer_page_bloc.dart';
import 'like_form.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({
    super.key,
    required this.editCommentFormFieldKey,
    required this.contentController,
    required this.questionInfo,
    required this.answerInfo,
    required this.detailAnswerPageBloc,
    required this.commentInfo,
    required this.checkOwner
  });

  final DataCommentModal commentInfo;
  final DataAnswerModal answerInfo;
  final DataQuestionModal questionInfo;
  final DetailAnswerPageBloc detailAnswerPageBloc;
  final TextEditingController contentController;
  final GlobalKey<FormState> editCommentFormFieldKey;
  final bool checkOwner;

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25, left: 30, right: 30),
      child: Column(
        children: [
          CommentModal(
            commentInfo: widget.commentInfo,
            detailAnswerPageBloc: widget.detailAnswerPageBloc,
            answerInfo: widget.answerInfo,
            questionInfo: widget.questionInfo,
            contentController: widget.contentController,
            checkOwner: widget.checkOwner,
            editCommentFormFieldKey: widget.editCommentFormFieldKey,
             ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xFFFDFFAE), Color(0xFFFFFFFF)])),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.commentInfo.contentComment,
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
