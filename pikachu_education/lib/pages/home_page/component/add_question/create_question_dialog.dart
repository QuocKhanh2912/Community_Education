import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/data/subject/list_subject.dart';
import 'package:pikachu_education/pages/home_page/bloc/get_image_to_create_question/get_image_bloc.dart';
import 'package:pikachu_education/pages/home_page/bloc/home_page/data_home_bloc.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:pikachu_education/utils/management_image.dart';
import 'package:pikachu_education/utils/management_time.dart';

class CreateQuestionPage extends StatefulWidget {
  const CreateQuestionPage(
      {super.key, required this.dataHomeBloc, required this.userCurrentInfo});

  final DataHomePageBloc dataHomeBloc;
  final DataUserModal userCurrentInfo;

  @override
  State<CreateQuestionPage> createState() => CreateQuestionPageState();
}

class CreateQuestionPageState extends State<CreateQuestionPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final formAddQuestionKey = GlobalKey<FormBuilderState>();

  File? _image;
  GetImageBloc getImageBloc = GetImageBloc();

  @override
  void dispose() {
    titleController.dispose();
    subjectController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.dataHomeBloc,
      child: BlocBuilder<DataHomePageBloc, DataHomePageState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => GetImageBloc(),
            child: BlocListener<GetImageBloc, GetImageState>(
              listener: (context, state) {
                if (state is GetImageSuccess) {
                  setState(() {
                    _image = state.image;
                  });
                }
              },
              child: BlocBuilder<GetImageBloc, GetImageState>(
                builder: (context, state) {
                  return AlertDialog(
                    backgroundColor: ManagementColor.lightYellow,
                    insetPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.zero,
                    alignment: Alignment.topCenter,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    content: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              AppLocalizations.of(context)?.newQuestion ?? '',
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
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        filled: true,
                                        fillColor: ManagementColor.white,
                                        labelText: AppLocalizations.of(context)
                                                ?.title ??
                                            ''),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                    name: AppLocalizations.of(context)?.title ??
                                        ''),
                                const SizedBox(
                                  height: 16,
                                ),
                                DropdownButtonFormField(
                                  validator: FormBuilderValidators.required(),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ManagementColor.white,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  icon: const Icon(
                                      Icons.arrow_drop_down_circle_outlined),
                                  hint: Text(
                                      AppLocalizations.of(context)?.subject ??
                                          ''),
                                  items: DataAddQuestion.listSubject
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      subjectController.text = value ?? '';
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                FormBuilderTextField(
                                    controller: contentController,
                                    maxLines: 3,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: ManagementColor.white,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        labelText: AppLocalizations.of(context)
                                                ?.content ??
                                            ''),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                    name:
                                        AppLocalizations.of(context)?.content ??
                                            '')
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
                                child: Text(
                                    AppLocalizations.of(context)?.addImageBy ??
                                        '',
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
                                      context.read<GetImageBloc>().add(
                                          GetImageByGalley(
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
                                                  color: ManagementColor.yellow,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                                  context)
                                                              ?.yourStorage ??
                                                          '',
                                                      style: const TextStyle(
                                                          color: ManagementColor
                                                              .grey,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.photo_library,
                                                    color: ManagementColor.grey,
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<GetImageBloc>().add(
                                          GetImageByGalley(
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
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                                  context)
                                                              ?.yourCamera ??
                                                          '',
                                                      style: const TextStyle(
                                                          color: ManagementColor
                                                              .grey,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    const Icon(
                                                      Icons.camera_alt_outlined,
                                                      color:
                                                          ManagementColor.grey,
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
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        AppLocalizations.of(context)?.cancel ??
                                            '',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: ManagementColor.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    formAddQuestionKey.currentState!.validate();
                                    if (formAddQuestionKey.currentState!
                                            .validate() ==
                                        true) {
                                      var item = DataQuestionModal(
                                          timePost:
                                              ManagementTime.getTimePost(),
                                          questionContent:
                                              contentController.text,
                                          questionSubject:
                                              subjectController.text,
                                          questionTitle: titleController.text,
                                          numberLike: 0,
                                          questionId: '',
                                          userName: '',
                                          userId: '',
                                          userAvatarUrl:
                                              widget.userCurrentInfo.avatarUrl);
                                      context.read<DataHomePageBloc>().add(
                                          PostDataQuestionsEvent(
                                              dataToPost: item,
                                              userId:
                                                  widget.userCurrentInfo.userId,
                                              file: _image));
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: ManagementColor.yellow,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        AppLocalizations.of(context)
                                                ?.createQuestion ??
                                            '',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: ManagementColor.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
