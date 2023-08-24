import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pikachu_education/data/data_modal/data_question_modal.dart';
import 'package:pikachu_education/pages/home_page/component/bloc_home_page/data_home_bloc.dart';
import 'package:pikachu_education/utils/management_time.dart';

class EditQuestionDialog extends StatefulWidget {
  const EditQuestionDialog(
      {super.key,
      required this.dataHomePageBloc,
      required this.titleController,
      required this.questionInfo,
      required this.contentController,
      required this.subjectController,
      required this.editQuestionFormFieldKey});

  final DataHomePageBloc dataHomePageBloc;
  final GlobalKey<FormState> editQuestionFormFieldKey;
  final TextEditingController titleController;
  final TextEditingController subjectController;
  final TextEditingController contentController;
  final DataQuestionModal questionInfo;

  @override
  State<EditQuestionDialog> createState() => _EditQuestionDialogState();
}

class _EditQuestionDialogState extends State<EditQuestionDialog> {
  @override
  void initState() {
    widget.titleController.text = widget.questionInfo.questionTitle;
    widget.subjectController.text = widget.questionInfo.questionSubject;
    widget.contentController.text = widget.questionInfo.questionContent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.dataHomePageBloc,
      child: BlocListener<DataHomePageBloc, DataHomePageState>(
        listener: (context, state) {
          if (state is EditQuestionSuccessState) {
              Navigator.pop(context);
          }
        },
        child: BlocBuilder<DataHomePageBloc, DataHomePageState>(
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: const Color(0xFFFDFFAE),
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              alignment: Alignment.topCenter,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              content: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'EDIT QUESTION',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Form(
                      key: widget.editQuestionFormFieldKey,
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
                          TextFormField(
                            controller: widget.subjectController,
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                labelText: 'Subject'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
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
                        TextButton(
                            onPressed: () {
                              var validator = widget
                                  .editQuestionFormFieldKey.currentState!
                                  .validate();
                              if (validator == true) {
                                var item = DataQuestionModal(
                                    timePost: ManagementTime.getTimePost(),
                                    questionId: widget.questionInfo.questionId,
                                    userId: widget.questionInfo.userId,
                                    userName: widget.questionInfo.userName,
                                    questionTitle:
                                        widget.titleController.text,
                                    questionSubject:
                                        widget.subjectController.text,
                                    questionContent:
                                        widget.contentController.text,
                                    numberLike: widget.questionInfo.numberLike,
                                    numberAnswer:
                                        widget.questionInfo.numberAnswer);
                                context.read<DataHomePageBloc>().add(
                                    EditQuestionsEvent(
                                        dataToPost: item,
                                        userIdOfQuestion: widget.questionInfo.userId,
                                        questionId:
                                            widget.questionInfo.questionId));

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
                            )),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
