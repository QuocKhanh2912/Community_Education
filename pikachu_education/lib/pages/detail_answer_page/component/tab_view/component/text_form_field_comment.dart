import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/data_modal/data_answer_modal.dart';
import 'package:pikachu_education/data/data_modal/data_comment_modal.dart';
import 'package:pikachu_education/data/data_modal/data_question_modal.dart';
import 'package:pikachu_education/data/data_modal/data_user_modal.dart';
import 'package:pikachu_education/pages/detail_answer_page/component/bloc_detail_answer_page/detail_answer_page_bloc.dart';
import 'package:pikachu_education/utils/management_time.dart';

class TextFormFieldComment extends StatefulWidget {
  const TextFormFieldComment(
      {super.key,
      required this.commentFormFieldKey,
      required this.commentController,
      required this.questionInfo,
      required this.currentUserInfo,
      required this.answerInfo});

  final TextEditingController commentController;
  final GlobalKey<FormState> commentFormFieldKey;
  final DataUserModal currentUserInfo;
  final DataQuestionModal questionInfo;
  final DataAnswerModal answerInfo;

  @override
  State<TextFormFieldComment> createState() => _TextFormFieldCommentState();
}

class _TextFormFieldCommentState extends State<TextFormFieldComment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Form(
          key: widget.commentFormFieldKey,
          child: TextFormField(
            controller: widget.commentController,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'User can not be empty';
              }
            },
            decoration: InputDecoration(
                hintText: 'Write Comment',
                hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0x4D000000)),
                suffixIcon: InkWell(
                  onTap: () async {
                    var validator =
                        widget.commentFormFieldKey.currentState!.validate();
                    if (validator == true) {
                      widget.commentFormFieldKey.currentState!.save();
                      var itemToPost = DataCommentModal(
                          contentComment: widget.commentController.text,
                          timePost: ManagementTime.getTimePost(),
                          userIdPostComment: widget.currentUserInfo.userId,
                          userNamePostComment: widget.currentUserInfo.userName,
                          commentId: '');
                      context.read<DetailAnswerPageBloc>().add(PostCommentEvent(
                          userIdOfQuestion: widget.questionInfo.userId,
                          questionId: widget.questionInfo.questionId,
                          itemToPost: itemToPost,
                          answerId: widget.answerInfo.answerId));
                    }
                  },
                  child: const Icon(
                    Icons.send,
                    color: Color(0xFFFF005C),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white),
          ),
        ),
      ),
    );
  }
}
