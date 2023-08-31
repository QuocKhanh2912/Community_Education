import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/pages/home_page/bloc/home_page/data_home_bloc.dart';
import 'package:pikachu_education/utils/management_color.dart';


class DeleteQuestionDialog extends StatefulWidget {
  const DeleteQuestionDialog(
      {super.key, required this.dataHomePageBloc, required this.questionInfo});

  final DataHomePageBloc dataHomePageBloc;
  final DataQuestionModal questionInfo;

  @override
  State<DeleteQuestionDialog> createState() => _DeleteQuestionDialogState();
}

class _DeleteQuestionDialogState extends State<DeleteQuestionDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.dataHomePageBloc,
      child: BlocListener<DataHomePageBloc, DataHomePageState>(
        listener: (context, state) {
          if(state is DeleteQuestionSuccessState){
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<DataHomePageBloc, DataHomePageState>(
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: const Color(0xFFFDFFAE),
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              alignment: Alignment.center,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20))),
              content: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'DELETE QUESTION',
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
                                  color: ManagementColor.white,
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
                            onPressed: () async {
                              context.read<DataHomePageBloc>().add(
                                  DeleteQuestionsEvent(
                                      userIdOfQuestion:
                                      widget.questionInfo.userId,
                                      questionId:
                                      widget.questionInfo.questionId));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 165,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: ManagementColor.yellow,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                'Delete',
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
