import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pikachu_education/data/modal/answer_modal.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/pages/answer_page/bloc/get_image_to_create_answer/get_image_to_create_answer_bloc.dart';
import 'package:pikachu_education/pages/answer_page/bloc/list_answer_page/list_answer_page_bloc.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:pikachu_education/utils/management_image.dart';
import 'package:pikachu_education/utils/management_time.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
                  backgroundColor: ManagementColor.lightYellow,
                  insetPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.zero,
                  content: StatefulBuilder(
                    builder:
                        (BuildContext context, StateSetter setStateForDialog) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                             Center(
                              child: Text(
                                AppLocalizations.of(context)?.postAnswer??'',
                                style: const TextStyle(
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
                                      decoration:  InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: AppLocalizations.of(context)?.title??''),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      name: AppLocalizations.of(context)?.title??''),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  FormBuilderTextField(
                                      controller: contentController,
                                      autofocus: false,
                                      maxLines: 8,
                                      keyboardType: TextInputType.text,
                                      decoration:  InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          filled: true,
                                          fillColor: ManagementColor.white,
                                          labelText: AppLocalizations.of(context)?.content??''),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      name: AppLocalizations.of(context)?.content??'')
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
                                  color: ManagementColor.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all()),
                              child: Column(children: [
                                 Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(AppLocalizations.of(context)?.addImageBy??'',
                                      style: const TextStyle(
                                          color: ManagementColor.grey,
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
                                                child:  Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        AppLocalizations.of(context)?.yourStorage??'',
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    const Icon(
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
                                                    color: ManagementColor.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child:  Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context)?.yourCamera??'',
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      const Icon(
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
                                          color: ManagementColor.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          AppLocalizations.of(context)?.cancel??'',
                                          style: const TextStyle(
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
                                          color: ManagementColor.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          AppLocalizations.of(context)?.createAnswer??'',
                                          style: const TextStyle(
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
