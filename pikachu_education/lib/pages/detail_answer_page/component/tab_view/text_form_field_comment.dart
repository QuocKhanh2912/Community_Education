import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/modal/answer_modal.dart';
import 'package:pikachu_education/data/modal/comment_modal.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/pages/detail_answer_page/bloc/detail_answer_page/detail_answer_page_bloc.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:pikachu_education/utils/management_time.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
                return AppLocalizations.of(context)?.emptyComment??'';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)?.writeComment??'',
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
                          timePost: DateTime.now().toString(),
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
                    color: ManagementColor.red,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: ManagementColor.white),
          ),
        ),
      ),
    );
  }
}
