import 'package:flutter/material.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/pages/answer_page/bloc/list_answer_page/list_answer_page_bloc.dart';
import 'package:pikachu_education/pages/answer_page/component/post_answer/create_answer_page.dart';
import 'package:pikachu_education/pages/authentication/component/dialog_custom.dart';
import 'package:pikachu_education/utils/management_color.dart';


class PostAnswerButton extends StatefulWidget {
  const PostAnswerButton(
      {super.key,
      required this.listAnswerPageBloc,
      required this.questionInfo,
     required this.currentUserInfo});

  final ListAnswerPageBloc listAnswerPageBloc;
  final DataQuestionModal questionInfo;
  final DataUserModal currentUserInfo;

  @override
  State<PostAnswerButton> createState() => _PostAnswerButtonState();
}

class _PostAnswerButtonState extends State<PostAnswerButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          color: Colors.transparent,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ManagementColor.yellow),
              ),
              onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => CreateAnswerPage(
                            listAnswerPageBloc: widget.listAnswerPageBloc,
                            userIdOfQuestion: widget.questionInfo.userId,
                            questionId: widget.questionInfo.questionId,
                            currentUserId: widget.currentUserInfo.userId,
                            currentUserName: widget.currentUserInfo.userName,
                        currentUserInfo: widget.currentUserInfo,
                          ));
                },
              child: const Text(
                'Post Answer',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ManagementColor.white,
                    fontSize: 25),
              )),
        ),
      ),
    );
  }
}
