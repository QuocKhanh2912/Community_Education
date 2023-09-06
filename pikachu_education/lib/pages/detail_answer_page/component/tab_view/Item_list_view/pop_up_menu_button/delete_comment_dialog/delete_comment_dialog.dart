import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/modal/answer_modal.dart';
import 'package:pikachu_education/data/modal/comment_modal.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/pages/detail_answer_page/bloc/detail_answer_page/detail_answer_page_bloc.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class DeleteCommentDialog extends StatefulWidget {
  const DeleteCommentDialog(
      {super.key,
      required this.detailAnswerPageBloc,
      required this.questionInfo,
      required this.answerInfo,
      required this.commentInfo});

  final DetailAnswerPageBloc detailAnswerPageBloc;
  final DataQuestionModal questionInfo;
  final DataAnswerModal answerInfo;
  final DataCommentModal commentInfo;

  @override
  State<DeleteCommentDialog> createState() => _DeleteCommentDialogState();
}

class _DeleteCommentDialogState extends State<DeleteCommentDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.detailAnswerPageBloc,
      child: BlocListener<DetailAnswerPageBloc, DetailAnswerPageState>(
        listener: (context, state) {
          if (state is DeleteCommentSuccessState){
            Navigator.pop(context);
          }
        },
        child: AlertDialog(
          backgroundColor: ManagementColor.lightYellow,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                 Center(
                  child: Text(
                    AppLocalizations.of(context)?.deleteAnswer??'',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ManagementColor.red),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 165,
                          height: 50,
                          decoration: BoxDecoration(
                              color: ManagementColor.white,
                              borderRadius: BorderRadius.circular(10)),
                          child:  Text(
                            AppLocalizations.of(context)?.cancel??'',
                            style: const TextStyle(
                                fontSize: 20,
                                color: ManagementColor.red,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    BlocBuilder<DetailAnswerPageBloc, DetailAnswerPageState>(
                      builder: (context, state) {
                        return TextButton(
                            onPressed: () async {
                              context.read<DetailAnswerPageBloc>().add(
                                  DeleteCommentEvent(
                                      userIdOfQuestion:
                                          widget.questionInfo.userId,
                                      questionId:
                                          widget.questionInfo.questionId,
                                      answerId: widget.answerInfo.answerId,
                                      commentId: widget.commentInfo.commentId));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 165,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: ManagementColor.yellow,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                AppLocalizations.of(context)?.delete??'',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: ManagementColor.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
