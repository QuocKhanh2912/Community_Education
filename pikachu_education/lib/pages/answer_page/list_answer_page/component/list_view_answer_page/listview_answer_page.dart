import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blog/blog_list_answer_page/list_answer_page_bloc.dart';

import '../../../../../data/data_modal/data_question_modal.dart';
import 'item_listview.dart';

class ListViewAnswerPage extends StatefulWidget {
  const ListViewAnswerPage(
      {super.key,
      required this.listAnswerPageBloc,
      required this.questionInfo});

  final ListAnswerPageBloc listAnswerPageBloc;
  final DataQuestionModal questionInfo;

  @override
  State<ListViewAnswerPage> createState() => _ListViewAnswerPageState();
}

class _ListViewAnswerPageState extends State<ListViewAnswerPage> {
  @override
  void initState() {
    widget.listAnswerPageBloc.add(FetchDataAnswerList(
        userIdOfQuestion: widget.questionInfo.userId,
        questionId: widget.questionInfo.questionId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.listAnswerPageBloc,
      child: BlocBuilder<ListAnswerPageBloc, ListAnswerPageState>(
        builder: (context, state) {
          if (state is FetchListAnswerPageSuccessState) {
            var listDataFromSever = state.listAnswers;
            if (listDataFromSever.isNotEmpty) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 8, right: 8),
                  child: ListView.builder(
                    itemBuilder: (context, index) => ItemListView(
                      listAnswerPageBloc: widget.listAnswerPageBloc,
                      index: index,
                      listDataFromSever: listDataFromSever,
                    ),
                    itemCount: listDataFromSever.length,
                  ),
                ),
              );
            } else {
              return const Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Nobody can give answer for this question, please add answer to this question or visit another time. Thanks!!!',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
              ));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
