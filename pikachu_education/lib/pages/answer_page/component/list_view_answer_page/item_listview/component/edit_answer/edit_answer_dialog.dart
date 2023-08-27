import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pikachu_education/data/data_modal/data_answer_modal.dart';
import 'package:pikachu_education/data/data_modal/data_question_modal.dart';
import 'package:pikachu_education/pages/answer_page/component/bloc_list_answer_page/list_answer_page_bloc.dart';
import 'package:pikachu_education/utils/management_time.dart';


class EditAnswerDialog extends StatefulWidget {
  const EditAnswerDialog({super.key,
    required this.titleController,
    required this.questionInfo,
    required this.contentController,
    required this.editAnswerFormFieldKey,
    required this.answerInfo, required this.listAnswerPageBloc});

  final GlobalKey<FormState> editAnswerFormFieldKey;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final DataQuestionModal questionInfo;
  final DataAnswerModal answerInfo;
  final ListAnswerPageBloc listAnswerPageBloc;

  @override
  State<EditAnswerDialog> createState() => _EditAnswerDialogState();
}

class _EditAnswerDialogState extends State<EditAnswerDialog> {
  @override
  void initState() {
    widget.titleController.text = widget.answerInfo.answerTitle;
    widget.contentController.text = widget.answerInfo.answerContent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.listAnswerPageBloc,
      child: BlocListener<ListAnswerPageBloc, ListAnswerPageState>(
        listener: (context, state) {
          if(state is EditAnswerSuccessState){
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
                    'EDIT ANSWER',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Form(
                  key: widget.editAnswerFormFieldKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: widget.titleController,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Title'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
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
                            labelText: 'Content'),
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
                    BlocBuilder<ListAnswerPageBloc, ListAnswerPageState>(
                      builder: (context, state) {
                        return TextButton(
                            onPressed: () {
                              var validator = widget
                                  .editAnswerFormFieldKey.currentState!
                                  .validate();
                              if (validator == true) {
                                var item = DataAnswerModal(
                                    timePost: ManagementTime.getTimePost(),
                                    answerId: widget.answerInfo.answerId,
                                    userIdPost: widget.answerInfo.userIdPost,
                                    userNamePost: widget.answerInfo
                                        .userNamePost,
                                    answerTitle: widget.titleController.text,
                                    answerContent: widget.contentController
                                        .text,
                                    numberLike: widget.questionInfo.numberLike,
                                    numberComment: widget.answerInfo
                                        .numberComment);
                                context.read<ListAnswerPageBloc>().add(
                                    EditAnswerEvent(
                                        userIdOfQuestion: widget.questionInfo
                                            .userId,
                                        questionId: widget.questionInfo
                                            .questionId,
                                        itemToPost: item,
                                        answerId: widget.answerInfo.answerId));
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
