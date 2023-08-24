import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pikachu_education/data/data_modal/data_answer_modal.dart';
import 'package:pikachu_education/data/data_modal/data_user_modal.dart';
import 'package:pikachu_education/pages/answer_page/component/bloc_get_image_to_create_answer/get_image_to_create_answer_bloc.dart';
import 'package:pikachu_education/pages/answer_page/component/bloc_list_answer_page/list_answer_page_bloc.dart';
import 'package:pikachu_education/utils/management_image.dart';
import 'package:pikachu_education/utils/management_time.dart';

class CreateAnswerPage extends StatefulWidget {
  const CreateAnswerPage(
      {super.key,
      required this.listAnswerPageBloc,
      required this.questionId,
      required this.userIdOfQuestion,
      required this.currentUserId,
      required this.currentUserName,required this.currentUserInfo});

  final DataUserModal currentUserInfo;
  final ListAnswerPageBloc listAnswerPageBloc;
  final String userIdOfQuestion;
  final String questionId;
  final String currentUserName;
  final String currentUserId;

  @override
  State<CreateAnswerPage> createState() => _CreateAnswerPageState();
}

class _CreateAnswerPageState extends State<CreateAnswerPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final formAddQuestionKey = GlobalKey<FormBuilderState>();
  final GetImageToCreateAnswerBloc getImageToCreateAnswerBloc =
      GetImageToCreateAnswerBloc();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.listAnswerPageBloc,
      child: BlocListener<ListAnswerPageBloc, ListAnswerPageState>(
        listener: (context, state) {
          if (state is PostAnswerSuccessState) {
            Navigator.pop(context);
          }
        },
        child: BlocProvider.value(
          value: getImageToCreateAnswerBloc,
          child: BlocListener<GetImageToCreateAnswerBloc,
              GetImageToCreateAnswerState>(
            listener: (context, state) {
              if(state is GetImageToCreateAnswerSuccess){
                setState(() {
                  _image=state.image;
                });
              }
            },
            child: BlocBuilder<GetImageToCreateAnswerBloc,
                GetImageToCreateAnswerState>(
              builder: (context, state) {
                return AlertDialog(
                  backgroundColor: Color(0xFFFDFFAE),
                  insetPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.zero,
                  content: StatefulBuilder(
                    builder:
                        (BuildContext context, StateSetter setStateForDialog) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                'POST ANSWER',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            FormBuilder(
                              key: formAddQuestionKey,
                              child: Column(
                                children: [
                                  FormBuilderTextField(
                                      controller: titleController,
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: 'Title'),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      name: 'title'),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  FormBuilderTextField(
                                      controller: contentController,
                                      autofocus: false,
                                      maxLines: 8,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: 'Content'),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      name: 'content')
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _image == null
                                ? Image.asset(ManagementImage.logo)
                                : Image.file(_image!),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all()),
                              child: Column(children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Add Image By:',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.read<GetImageToCreateAnswerBloc>().add(
                                            GetImageToCreateAnswerByGalleyEvent(
                                                source: ImageSource.gallery));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFFDCA15),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                        'Your Storage',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.photo_library,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context.read<GetImageToCreateAnswerBloc>().add(
                                            GetImageToCreateAnswerByGalleyEvent(
                                                source: ImageSource.camera));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFFDCA15),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Your Camera',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .camera_alt_outlined,
                                                        color: Colors.grey,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ]),
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
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFD9D9D9),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      formAddQuestionKey.currentState!
                                          .validate();
                                      if (formAddQuestionKey.currentState!
                                              .validate() ==
                                          true) {
                                        var item = DataAnswerModal(
                                          userAvatarUrl: widget.currentUserInfo.avatarUrl??'',
                                            userIdPost: widget.currentUserId,
                                            userNamePost:
                                                widget.currentUserName,
                                            answerId: '',
                                            timePost:
                                                ManagementTime.getTimePost(),
                                            answerContent:
                                                contentController.text,
                                            answerTitle: titleController.text,
                                            numberLike: 0);
                                        context.read<ListAnswerPageBloc>().add(
                                            PostAnswerEvent(
                                                userIdOfQuestion:
                                                    widget.userIdOfQuestion,
                                                questionId: widget.questionId,
                                                itemToPost: item,file: _image));
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFDCA15),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Create Answer',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
