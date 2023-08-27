import 'package:flutter/material.dart';
import 'package:pikachu_education/data/data_modal/data_question_modal.dart';
import 'package:pikachu_education/pages/home_page/component/bloc_home_page/data_home_bloc.dart';
import 'component/decline_dialog.dart';
import 'component/delete_question/delete_question_dialog.dart';
import 'component/edit_questions/edit_question_dialog.dart';

class PopUpMenuButtonHomePage extends StatefulWidget {
  const PopUpMenuButtonHomePage(
      {super.key,
      required this.dataHomePageBloc,
      required this.contentController,
      required this.editQuestionFormFieldKey,
      required this.subjectController,
      required this.dataQuestionFromServer,
      required this.index,
      required this.checkOwner,
      required this.titleController});

  final bool checkOwner;
  final List<DataQuestionModal> dataQuestionFromServer;
  final DataHomePageBloc dataHomePageBloc;
  final int index;
  final GlobalKey<FormState> editQuestionFormFieldKey;
  final TextEditingController titleController;
  final TextEditingController subjectController;
  final TextEditingController contentController;

  @override
  State<PopUpMenuButtonHomePage> createState() => _PopUpMenuButtonHomePageState();
}

class _PopUpMenuButtonHomePageState extends State<PopUpMenuButtonHomePage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                              builder: (context) => EditQuestionDialog(
                                    questionInfo: widget
                                        .dataQuestionFromServer[widget.index],
                                    dataHomePageBloc: widget.dataHomePageBloc,
                                    contentController: widget.contentController,
                                    editQuestionFormFieldKey:
                                        widget.editQuestionFormFieldKey,
                                    subjectController: widget.subjectController,
                                    titleController: widget.titleController,
                                  ));
                          Navigator.pop(context);
                        } else {
                          await showDialog(
                              context: context,
                              builder: (context) => const DeclineDialog());
                          Navigator.pop(context);
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
                              builder: (context) => DeleteQuestionDialog(
                                    dataHomePageBloc: widget.dataHomePageBloc,
                                    questionInfo: widget
                                        .dataQuestionFromServer[widget.index],
                                  ));
                          Navigator.pop(context);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => const DeclineDialog());
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
    );
  }
}
