import 'package:flutter/material.dart';
import 'package:pikachu_education/data/modal/answer_modal.dart';
import 'package:pikachu_education/data/modal/comment_modal.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/pages/detail_answer_page/bloc/detail_answer_page/detail_answer_page_bloc.dart';
import 'package:pikachu_education/pages/detail_answer_page/component/tab_view/Item_list_view/pop_up_menu_button/pop_up_menu_button.dart';
import 'package:pikachu_education/utils/management_image.dart';



class CommentModal extends StatefulWidget {
  const CommentModal(
      {super.key,
      required this.editCommentFormFieldKey,
      required this.contentController,
      required this.questionInfo,
      required this.answerInfo,
      required this.detailAnswerPageBloc,
      required this.commentInfo,
      required this.checkOwner});

  final DataCommentModal commentInfo;
  final DataAnswerModal answerInfo;
  final DataQuestionModal questionInfo;
  final DetailAnswerPageBloc detailAnswerPageBloc;
  final TextEditingController contentController;
  final GlobalKey<FormState> editCommentFormFieldKey;
  final bool checkOwner;

  @override
  State<CommentModal> createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
          width: MediaQuery.of(context).size.width / 6,
          child: Image.asset(ManagementImage.defaultAvatar, fit: BoxFit.fill)),
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.commentInfo.userNamePostComment,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.commentInfo.timePost,
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
      PopUpMenuButtonComment(
        commentInfo: widget.commentInfo,
        detailAnswerPageBloc: widget.detailAnswerPageBloc,
        answerInfo: widget.answerInfo,
        questionInfo: widget.questionInfo,
        contentController: widget.contentController,
        checkOwner: widget.checkOwner,
        editCommentFormFieldKey: widget.editCommentFormFieldKey,
      )
    ]);
  }
}
