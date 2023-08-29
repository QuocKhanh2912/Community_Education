import 'package:flutter/material.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/pages/answer_page/bloc/list_answer_page/list_answer_page_bloc.dart';
import 'package:pikachu_education/pages/answer_page/component/post_answer/create_answer_page.dart';
import 'package:pikachu_education/pages/authentication/component/dialog_custom.dart';


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
                    MaterialStateProperty.all(const Color(0xFFFDCA15)),
              ),
              onPressed: () {
                if (widget.currentUserInfo.userName.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogCustom.dialogOfPostAnswer(context);
                    },
                  );
                } else {
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
                  // showModalBottomSheet(
                  //     backgroundColor: const Color(0xFFFDFFAE),
                  //     shape: const RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.vertical(
                  //             top: Radius.circular(20))),
                  //     context: context,
                  //     builder: (context) {

                  // });
                }
              },
              child: const Text(
                'Post Answer',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25),
              )),
        ),
      ),
    );
  }
}
