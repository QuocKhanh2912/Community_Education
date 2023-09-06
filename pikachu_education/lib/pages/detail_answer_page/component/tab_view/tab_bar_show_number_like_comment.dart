import 'package:flutter/material.dart';
import 'package:pikachu_education/data/modal/answer_modal.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TabBarShowNumberLikeComment extends StatefulWidget {
  const TabBarShowNumberLikeComment({super.key,required this.answerInfo,required this.tabController});

  final TabController tabController;
  final DataAnswerModal answerInfo;

  @override
  State<TabBarShowNumberLikeComment> createState() => _TabBarShowNumberLikeCommentState();
}

class _TabBarShowNumberLikeCommentState extends State<TabBarShowNumberLikeComment> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
        overlayColor: MaterialStateProperty.all(ManagementColor.white),
        indicatorColor: ManagementColor.lightYellow,
        controller: widget.tabController,
        tabs: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                '${widget.answerInfo.numberComment} ${AppLocalizations.of(context)?.comment??''}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${widget.answerInfo.numberLike} ${AppLocalizations.of(context)?.like??''}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ]);
  }
}
