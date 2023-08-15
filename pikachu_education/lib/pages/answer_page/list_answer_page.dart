import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/data_modal/data_user_modal.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/service/database_service/database_service_answer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../bloc/bloc_list_answer_page/list_answer_page_bloc.dart';
import '../../data/data_modal/data_question_modal.dart';
import '../../service/database_service/database_service.dart';
import 'component/detail_question.dart';
import 'component/list_view_answer_page/listview_answer_page.dart';
import 'component/post_answer_button.dart';

class ListAnswerPage extends StatefulWidget {
  const ListAnswerPage(
      {super.key, required this.questionInfo, required this.currentUserInfo});

  final DataQuestionModal questionInfo;
  final DataUserModal currentUserInfo;

  @override
  State<ListAnswerPage> createState() => _ListAnswerPageState();
}

class _ListAnswerPageState extends State<ListAnswerPage> {
  final ListAnswerPageBloc _listAnswerPageBloc = ListAnswerPageBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final TextEditingController contentController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final GlobalKey<FormState> editAnswerFormFieldKey = GlobalKey<FormState>();
  List<String> listAnswerIdLiked=[];

  getListQuestionIdLiked({required String userId}) async {
    var listQuestionIdLikeFromSever =
    await AnswerDatabaseService.getListAnswerIdLiked(currentUserId: userId);
    setState(() {
      listAnswerIdLiked = listQuestionIdLikeFromSever;
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getListQuestionIdLiked(userId: widget.currentUserInfo.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _listAnswerPageBloc,
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<ListAnswerPageBloc, ListAnswerPageState>(
            listener: (context, state) {
              if (state is FetchListAnswerPageSuccessState) {
                _refreshController.refreshCompleted();
              }
              if (state is DeleteAnswerSuccessState) {
                context.read<ListAnswerPageBloc>().add(
                    RefreshDataAnswerListEvent(
                        userIdOfQuestion: widget.questionInfo.userId,
                        questionId: widget.questionInfo.questionId));
              }
              if (state is EditAnswerSuccessState) {
                context.read<ListAnswerPageBloc>().add(
                    RefreshDataAnswerListEvent(
                        userIdOfQuestion: widget.questionInfo.userId,
                        questionId: widget.questionInfo.questionId));
              }
              if (state is LikeAnswerSuccessState) {
                context.read<ListAnswerPageBloc>().add(
                    RefreshDataAnswerListEvent(
                        userIdOfQuestion: widget.questionInfo.userId,
                        questionId: widget.questionInfo.questionId));
                getListQuestionIdLiked(userId: widget.currentUserInfo.userId);
              }
              if (state is RemoveLikeAnswerSuccessState) {
                context.read<ListAnswerPageBloc>().add(
                    RefreshDataAnswerListEvent(
                        userIdOfQuestion: widget.questionInfo.userId,
                        questionId: widget.questionInfo.questionId));
                getListQuestionIdLiked(userId: widget.currentUserInfo.userId);
              }
            },
            child: BlocBuilder<ListAnswerPageBloc, ListAnswerPageState>(
              builder: (context, state) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                padding: EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PageName.profilePage,arguments: widget.currentUserInfo);
                                  },
                                  child: Text(
                                      (widget.currentUserInfo.userName.length ??
                                                  0) ==
                                              0
                                          ? 'Login'
                                          : widget.currentUserInfo.userName,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal)),
                                ),
                              )
                            ]),
                      ),
                      DetailQuestion(dataQuestionInfo: widget.questionInfo),
                      PostAnswerButton(
                        listAnswerPageBloc: _listAnswerPageBloc,
                        currentUserInfo: widget.currentUserInfo,
                        questionInfo: widget.questionInfo,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 10, right: 10),
                        child: Text(
                            '${widget.questionInfo.numberAnswer} Answers',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: SmartRefresher(
                          controller: _refreshController,
                          onRefresh: () {
                            context.read<ListAnswerPageBloc>().add(
                                RefreshDataAnswerListEvent(
                                    userIdOfQuestion:
                                        widget.questionInfo.userId,
                                    questionId:
                                        widget.questionInfo.questionId));
                          },
                          child: ListViewAnswerPage(listAnswerIdLiked: listAnswerIdLiked,
                            editAnswerFormFieldKey: editAnswerFormFieldKey,
                            contentController: contentController,
                            titleController: titleController,
                            listAnswerPageBloc: _listAnswerPageBloc,
                            questionInfo: widget.questionInfo,
                            currentUserInfo: widget.currentUserInfo,
                          ),
                        ),
                      )
                    ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
