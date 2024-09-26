import 'package:flutter/material.dart';
import 'package:pikachu_education/data/modal/answer_modal.dart';
import 'package:pikachu_education/utils/extensions/datetime_extension.dart';

import '../../../../../utils/management_image.dart';

class AnswerDetail extends StatefulWidget {
  const AnswerDetail({super.key,required this.answerInfo});
final DataAnswerModal answerInfo;
  @override
  State<AnswerDetail> createState() => _AnswerDetailState();
}

class _AnswerDetailState extends State<AnswerDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFFFDFFAE), Color(0xFFFFFFFF)]),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 6,
                  child: Image.asset(
                      ManagementImage.defaultAvatar,
                      fit: BoxFit.fill)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.answerInfo.userNamePost,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.answerInfo.timePost.formatDateTime(context),
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.answerInfo.answerTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.answerInfo.answerContent),
          ),
        ],
      ),
    );
  }
}
