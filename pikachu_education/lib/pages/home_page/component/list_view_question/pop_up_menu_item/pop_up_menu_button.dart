import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/pages/home_page/bloc/home_page/data_home_bloc.dart';
import 'package:pikachu_education/pages/home_page/component/list_view_question/pop_up_menu_item/delete_question/delete_question_dialog.dart';
import 'package:pikachu_education/pages/home_page/component/list_view_question/pop_up_menu_item/edit_questions/edit_question_dialog.dart';
import 'decline_dialog/decline_dialog.dart';

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
  State<PopUpMenuButtonHomePage> createState() =>
      _PopUpMenuButtonHomePageState();
}

class _PopUpMenuButtonHomePageState extends State<PopUpMenuButtonHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.dataHomePageBloc,
      child: Expanded(
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: PopupMenuButton(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: InkWell(
                        onTap: ()  {
                          if (widget.checkOwner) {
                             showDialog(
                                context: context,
                                builder: (context) => EditQuestionDialog(
                                      questionInfo:
                                          widget.dataQuestionFromServer[
                                              widget.index],
                                      dataHomePageBloc:
                                          widget.dataHomePageBloc,
                                      contentController:
                                          widget.contentController,
                                      editQuestionFormFieldKey:
                                          widget.editQuestionFormFieldKey,
                                      subjectController:
                                          widget.subjectController,
                                      titleController: widget.titleController,
                                    )).then((value) => Navigator.pop(context));
                          } else {
                             showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const DeclineDialog())
                                .then((value) => Navigator.pop(context));
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
                        onTap: ()  {
                          if (widget.checkOwner) {
                             showDialog(
                                context: context,
                                builder: (context) => DeleteQuestionDialog(
                                      dataHomePageBloc:
                                          widget.dataHomePageBloc,
                                      questionInfo:
                                          widget.dataQuestionFromServer[
                                              widget.index],
                                    )) .then((value) => Navigator.pop(context));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => const DeclineDialog()).then((value) => Navigator.pop(context));
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            Text('Delete',
                                style: TextStyle(color: Colors.red)),
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
