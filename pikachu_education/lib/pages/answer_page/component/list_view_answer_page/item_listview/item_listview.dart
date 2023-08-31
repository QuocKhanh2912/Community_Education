import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/modal/answer_modal.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/pages/answer_page/bloc/list_answer_page/list_answer_page_bloc.dart';
import 'package:pikachu_education/pages/answer_page/component/list_view_answer_page/item_listview/pop_up_menu_button.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/utils/management_image.dart';

class ItemListView extends StatefulWidget {
  const ItemListView(
      {super.key,
      required this.index,
      required this.listAnswerPageBloc,
      required this.listDataAnswerFromSever,
      required this.currentUserInfo,
      required this.questionInfo,
      required this.contentController,
      required this.titleController,
      required this.editAnswerFormFieldKey,
      required this.listAnswerIdLiked});

  final ListAnswerPageBloc listAnswerPageBloc;
  final List<DataAnswerModal> listDataAnswerFromSever;
  final DataUserModal currentUserInfo;
  final DataQuestionModal questionInfo;
  final GlobalKey<FormState> editAnswerFormFieldKey;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final int index;
  final List<String> listAnswerIdLiked;

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    bool checkLiked = widget.listAnswerIdLiked
        .contains(widget.listDataAnswerFromSever[widget.index].answerId);
    var checkOwner = widget.currentUserInfo.userId ==
        widget.listDataAnswerFromSever[widget.index].userIdPost;
    return BlocProvider.value(
        value: widget.listAnswerPageBloc,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, PageName.detailAnswerPage,
                    arguments: [
                      widget.listDataAnswerFromSever[widget.index],
                      widget.currentUserInfo,
                      widget.questionInfo,
                      widget.listAnswerPageBloc
                    ]);
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Color(0xFFFDFFAE), Color(0xFFFFFFFF)]),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              widget.listDataAnswerFromSever[widget.index]
                                          .userAvatarUrl ==
                                      ''
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Image.asset(
                                            ManagementImage.defaultAvatar,
                                            fit: BoxFit.fill,
                                          )),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Image.network(
                                            widget
                                                .listDataAnswerFromSever[
                                                    widget.index]
                                                .userAvatarUrl!,
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget
                                        .listDataAnswerFromSever[widget.index]
                                        .userNamePost),
                                    Text(
                                        widget
                                            .listDataAnswerFromSever[
                                                widget.index]
                                            .timePost,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0x4D000000)))
                                  ],
                                ),
                              )
                            ],
                          ),
                          PopUpMenuButtonAnswerPage(
                            listAnswerPageBloc: widget.listAnswerPageBloc,
                            questionInfo: widget.questionInfo,
                            answerInfo:
                                widget.listDataAnswerFromSever[widget.index],
                            editAnswerFormFieldKey:
                                widget.editAnswerFormFieldKey,
                            titleController: widget.titleController,
                            contentController: widget.contentController,
                            index: widget.index,
                            checkOwner: checkOwner,
                            dataAnswerFromServer:
                                widget.listDataAnswerFromSever,
                          )
                        ],
                      ),
                    ),
                    Text(
                        widget
                            .listDataAnswerFromSever[widget.index].answerTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.listDataAnswerFromSever[widget.index]
                            .answerContent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                          child: (widget.listDataAnswerFromSever[widget.index]
                                      .imageUrl) ==
                                  ''
                              ? const SizedBox()
                              : Image.network(widget
                                  .listDataAnswerFromSever[widget.index]
                                  .imageUrl!)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (checkLiked) {
                                context.read<ListAnswerPageBloc>().add(
                                    RemoveLikeAnswersEvent(
                                        userIdOfQuestion:
                                            widget.questionInfo.userId,
                                        currentUserId:
                                            widget.currentUserInfo.userId,
                                        questionId:
                                            widget.questionInfo.questionId,
                                        answerId: widget
                                            .listDataAnswerFromSever[
                                                widget.index]
                                            .answerId));
                              } else {
                                context.read<ListAnswerPageBloc>().add(
                                    LikeAnswersEvent(
                                        userIdOfQuestion:
                                            widget.questionInfo.userId,
                                        currentUserId:
                                            widget.currentUserInfo.userId,
                                        questionId:
                                            widget.questionInfo.questionId,
                                        answerId: widget
                                            .listDataAnswerFromSever[
                                                widget.index]
                                            .answerId));
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  checkLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                Text(
                                    '${widget.listDataAnswerFromSever[widget.index].numberLike} like'),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.comment_sharp),
                              Text(
                                  '${widget.listDataAnswerFromSever[widget.index].numberComment} comment'),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SizedBox(
                                    width: 23,
                                    height: 23,
                                    child: Image.asset(
                                      ManagementImage.defaultAvatar,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                        widget
                                            .listDataAnswerFromSever[
                                                widget.index]
                                            .userNamePost,
                                        softWrap: false,
                                        overflow: TextOverflow.fade),
                                  ),
                                  Text(
                                      widget
                                          .listDataAnswerFromSever[widget.index]
                                          .timePost,
                                      style: const TextStyle(
                                          fontSize: 8,
                                          color: Color(0x4D000000)))
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
