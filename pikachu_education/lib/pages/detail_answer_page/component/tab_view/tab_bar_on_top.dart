import 'package:flutter/material.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/routes/page_name.dart';


class TabBarOnTop extends StatefulWidget {
  const TabBarOnTop(
      {super.key, required this.questionInfo, required this.currentUserInfo});

  final DataQuestionModal questionInfo;
  final DataUserModal currentUserInfo;

  @override
  State<TabBarOnTop> createState() => _TabBarOnTopState();
}

class _TabBarOnTopState extends State<TabBarOnTop> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back, size: 25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, PageName.profilePage,
                  arguments: widget.currentUserInfo);
            },
            child: Text(
                widget.currentUserInfo.userName.isEmpty
                    ? widget.currentUserInfo.phoneNumber ?? ''
                    : widget.currentUserInfo.userName,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.normal)),
          ),
        )
      ]),
    );
  }
}
