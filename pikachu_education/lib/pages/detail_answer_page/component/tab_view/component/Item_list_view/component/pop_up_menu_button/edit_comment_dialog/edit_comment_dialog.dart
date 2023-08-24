import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pikachu_education/data/data_modal/data_answer_modal.dart';
import 'package:pikachu_education/data/data_modal/data_comment_modal.dart';
import 'package:pikachu_education/data/data_modal/data_question_modal.dart';
import 'package:pikachu_education/pages/detail_answer_page/component/bloc_detail_answer_page/detail_answer_page_bloc.dart';
import 'package:pikachu_education/utils/management_time.dart';


class EditCommentDialog extends StatefulWidget {
  const EditCommentDialog(
      {super.key,
      required this.questionInfo,
      required this.contentController,
      required this.editCommentFormFieldKey,
      required this.answerInfo,
      required this.detailAnswerPageBloc,
      required this.commentInfo});

  final GlobalKey<FormState> editCommentFormFieldKey;
  final TextEditingController contentController;
  final DataQuestionModal questionInfo;
  final DataAnswerModal answerInfo;
  final DataCommentModal commentInfo;
  final DetailAnswerPageBloc detailAnswerPageBloc;

  @override
  State<EditCommentDialog> createState() => _EditCommentDialogState();
}

class _EditCommentDialogState extends State<EditCommentDialog> {
  @override
  void initState() {
    widget.contentController.text = widget.commentInfo.contentComment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.detailAnswerPageBloc,
      child: BlocListener<DetailAnswerPageBloc, DetailAnswerPageState>(
        listener: (context, state) {
          if(state is EditCommentSuccessState){
            Navigator.pop(context);
          }
        },
        child: AlertDialog(
          backgroundColor: const Color(0xFFFDFFAE),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          alignment: Alignment.topCenter,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'EDIT Comment',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Form(
                  key: widget.editCommentFormFieldKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: widget.contentController,
                        maxLines: 8,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Edit Comment'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
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
                              color: const Color(0xFFD9D9D9),
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
                            onPressed: () {
                              var validator = widget
                                  .editCommentFormFieldKey.currentState!
                                  .validate();
                              if (validator == true) {
                                var item = DataCommentModal(
                                  timePost: ManagementTime.getTimePost(),
                                  commentId: widget.commentInfo.commentId,
                                  contentComment: widget.contentController.text,
                                  userIdPostComment:
                                      widget.commentInfo.userIdPostComment,
                                  userNamePostComment:
                                      widget.commentInfo.userNamePostComment,
                                );
                                context.read<DetailAnswerPageBloc>().add(
                                    EditCommentEvent(
                                        userIdOfQuestion:
                                            widget.questionInfo.userId,
                                        questionId:
                                            widget.questionInfo.questionId,
                                        itemToPost: item,
                                        answerId: widget.answerInfo.answerId,
                                        commentId:
                                            widget.commentInfo.commentId));
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 165,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFDCA15),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                'Edit Question',
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
