import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/modal/answer_modal.dart';
import 'package:pikachu_education/data/modal/comment_modal.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/pages/detail_answer_page/bloc/detail_answer_page/detail_answer_page_bloc.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'decline_dialog.dart';
import 'delete_comment_dialog/delete_comment_dialog.dart';
import 'edit_comment_dialog/edit_comment_dialog.dart';


class PopUpMenuButtonComment extends StatefulWidget {
  const PopUpMenuButtonComment(
      {super.key,
      required this.answerInfo,
      required this.editCommentFormFieldKey,
      required this.contentController,
      required this.questionInfo,
      required this.checkOwner,
      required this.detailAnswerPageBloc,
      required this.commentInfo});

  final DataAnswerModal answerInfo;
  final DataQuestionModal questionInfo;
  final TextEditingController contentController;
  final GlobalKey<FormState> editCommentFormFieldKey;
  final bool checkOwner;
  final DetailAnswerPageBloc detailAnswerPageBloc;
  final DataCommentModal commentInfo;

  @override
  State<PopUpMenuButtonComment> createState() => _PopUpMenuButtonCommentState();
}

class _PopUpMenuButtonCommentState extends State<PopUpMenuButtonComment> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.detailAnswerPageBloc,
      child: Expanded(
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: PopupMenuButton(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          if (widget.checkOwner) {
                            await showDialog(
                                context: context,
                                builder: (context) => EditCommentDialog(
                                      contentController:
                                          widget.contentController,
                                      questionInfo: widget.questionInfo,
                                      answerInfo: widget.answerInfo,
                                      editCommentFormFieldKey:
                                          widget.editCommentFormFieldKey,
                                      commentInfo: widget.commentInfo,
                                      detailAnswerPageBloc:
                                          widget.detailAnswerPageBloc,
                                    )).then((value) => Navigator.pop(context));
                          } else {
                            await showDialog(
                                context: context,
                                builder: (context) =>
                                    const DeclineDialogComment()).then((value) => Navigator.pop(context));

                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.edit),
                            Text('Edit'),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          if (widget.checkOwner) {
                            await showDialog(
                                context: context,
                                builder: (context) => DeleteCommentDialog(
                                      answerInfo: widget.answerInfo,
                                      questionInfo: widget.questionInfo,
                                      commentInfo: widget.commentInfo,
                                      detailAnswerPageBloc:
                                      widget.detailAnswerPageBloc,
                                    )).then((value) => Navigator.pop(context));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    const DeclineDialogComment()).then((value) => Navigator.pop(context));
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.delete, color: ManagementColor.red),
                            Text('Delete', style: TextStyle(color: ManagementColor.red)),
                          ],
                        ),
                      ),
                    ),
                  ]),
        ),
      ),
    );
  }
}
