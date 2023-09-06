import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/pages/answer_page/bloc/list_answer_page/list_answer_page_bloc.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'item_listview/item_listview.dart';

class ListViewAnswerPage extends StatefulWidget {
  const ListViewAnswerPage(
      {super.key,
      required this.listAnswerPageBloc,
      required this.questionInfo,
      required this.currentUserInfo,
      required this.contentController,
      required this.editAnswerFormFieldKey,
      required this.titleController,
      required this.listAnswerIdLiked});

  final ListAnswerPageBloc listAnswerPageBloc;
  final DataQuestionModal questionInfo;
  final DataUserModal currentUserInfo;
  final GlobalKey<FormState> editAnswerFormFieldKey;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final List<String> listAnswerIdLiked;

  @override
  State<ListViewAnswerPage> createState() => _ListViewAnswerPageState();
}

class _ListViewAnswerPageState extends State<ListViewAnswerPage> {
  @override
  void initState() {
    widget.listAnswerPageBloc.add(FetchDataAnswerListEvent(
        userIdOfQuestion: widget.questionInfo.userId,
        questionId: widget.questionInfo.questionId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.listAnswerPageBloc,
      child: BlocListener<ListAnswerPageBloc, ListAnswerPageState>(
        listener: (context, state) {
          if (state is PostAnswerSuccessState) {
            context.read<ListAnswerPageBloc>().add(RefreshDataAnswerListEvent(
                userIdOfQuestion: widget.questionInfo.userId,
                questionId: widget.questionInfo.questionId));
          }
        },
        child: BlocBuilder<ListAnswerPageBloc, ListAnswerPageState>(
          builder: (context, state) {
            if (state is FetchListAnswerPageSuccessState) {
              var listDataAnswerFromSever = state.listAnswers;
              if (listDataAnswerFromSever.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ItemListView(
                      listAnswerIdLiked: widget.listAnswerIdLiked,
                      titleController: widget.titleController,
                      contentController: widget.contentController,
                      editAnswerFormFieldKey: widget.editAnswerFormFieldKey,
                      listAnswerPageBloc: widget.listAnswerPageBloc,
                      index: index,
                      listDataAnswerFromSever: listDataAnswerFromSever,
                      currentUserInfo: widget.currentUserInfo,
                      questionInfo: widget.questionInfo,
                    ),
                    itemCount: listDataAnswerFromSever.length,
                  ),
                );
              } else {
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)?.noAnswer??'',
                      style: const TextStyle(
                          color: ManagementColor.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
