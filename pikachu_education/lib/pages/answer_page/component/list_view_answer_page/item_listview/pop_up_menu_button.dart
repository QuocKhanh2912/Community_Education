import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/modal/answer_modal.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/pages/answer_page/bloc/list_answer_page/list_answer_page_bloc.dart';
import 'decline_dialog.dart';
import 'delete_answer/delete_question_dialog.dart';
import 'edit_answer/edit_answer_dialog.dart';

class PopUpMenuButtonAnswerPage extends StatefulWidget {
  const PopUpMenuButtonAnswerPage({super.key,
    required this.answerInfo,
    required this.editAnswerFormFieldKey,
    required this.titleController,
    required this.contentController,
    required this.questionInfo,
    required this.checkOwner,
    required this.index,
    required this.dataAnswerFromServer,
    required this.listAnswerPageBloc});

  final DataAnswerModal answerInfo;
  final DataQuestionModal questionInfo;
  final TextEditingController contentController;
  final TextEditingController titleController;
  final GlobalKey<FormState> editAnswerFormFieldKey;
  final bool checkOwner;
  final List<DataAnswerModal> dataAnswerFromServer;
  final int index;
  final ListAnswerPageBloc listAnswerPageBloc;

  @override
  State<PopUpMenuButtonAnswerPage> createState() =>
      _PopUpMenuButtonAnswerPageState();
}

class _PopUpMenuButtonAnswerPageState extends State<PopUpMenuButtonAnswerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.listAnswerPageBloc,
      child: Expanded(
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: PopupMenuButton(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              itemBuilder: (context) =>
              <PopupMenuEntry>[
                PopupMenuItem(
                  child: InkWell(
                    onTap: () async {
                      if (widget.checkOwner) {
                        await showDialog(
                            context: context,
                            builder: (context) =>
                                EditAnswerDialog(
                                  questionInfo: widget.questionInfo,
                                  contentController: widget.contentController,
                                  titleController: widget.titleController,
                                  answerInfo: widget.answerInfo,
                                  editAnswerFormFieldKey:
                                  widget.editAnswerFormFieldKey,
                                  listAnswerPageBloc: widget.listAnswerPageBloc,
                                )).then((value) => Navigator.pop(context));

                      } else {
                        await showDialog(
                            context: context,
                            builder: (context) =>
                            const DeclineDialogAnswerPage()).then((value) => Navigator.pop(context));

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
                            builder: (context) =>
                                DeleteAnswerDialog(
                                  answerInfo: widget.answerInfo,
                                  questionInfo: widget.questionInfo,
                                  listAnswerPageBloc:
                                  widget.listAnswerPageBloc,
                                )).then((value) => Navigator.pop(context));

                      } else {
                        showDialog(
                            context: context,
                            builder: (context) =>
                            const DeclineDialogAnswerPage());
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        Text('Delete', style: TextStyle(color: Colors.red)),
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
