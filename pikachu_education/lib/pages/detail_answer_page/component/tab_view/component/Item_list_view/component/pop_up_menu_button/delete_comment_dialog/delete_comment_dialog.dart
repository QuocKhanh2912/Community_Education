import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/data_modal/data_answer_modal.dart';
import 'package:pikachu_education/data/data_modal/data_comment_modal.dart';
import 'package:pikachu_education/data/data_modal/data_question_modal.dart';
import 'package:pikachu_education/pages/detail_answer_page/component/bloc_detail_answer_page/detail_answer_page_bloc.dart';


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
          backgroundColor: const Color(0xFFFDFFAE),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'DELETE ANSWER',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
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
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
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
                                  color: Color(0xFFFDCA15),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
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
