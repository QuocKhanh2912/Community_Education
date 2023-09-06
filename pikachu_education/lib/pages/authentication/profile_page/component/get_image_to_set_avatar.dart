import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/pages/authentication/profile_page/bloc/image_to_set_avatar/get_image_to_set_avatar_bloc.dart';
import 'package:pikachu_education/pages/authentication/profile_page/bloc/profile_page/profile_page_bloc.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:pikachu_education/utils/management_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class GetImageToSetAvatar extends StatefulWidget {
  const GetImageToSetAvatar({super.key, required this.currentUserInfo});

  final DataUserModal currentUserInfo;

  @override
  State<GetImageToSetAvatar> createState() => _GetImageToSetAvatarState();
}

File? _image;

class _GetImageToSetAvatarState extends State<GetImageToSetAvatar> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageBloc(),
      child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => GetImageToSetAvatarBloc(),
            child:
                BlocListener<GetImageToSetAvatarBloc, GetImageToSetAvatarState>(
              listener: (context, state) {
                if (state is GetImageToCreateAnswerSuccess) {
                  setState(() {
                    _image = state.image;
                  });
                }
              },
              child: BlocListener<ProfilePageBloc, ProfilePageState>(
                listener: (context, state) {
                  if (state is PostAvatarSuccess) {
                    Navigator.pop(context);
                  }
                },
                child: BlocBuilder<GetImageToSetAvatarBloc,
                    GetImageToSetAvatarState>(
                  builder: (context, state) {
                    return AlertDialog(
                      backgroundColor: ManagementColor.lightYellow,
                      insetPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      content: StatefulBuilder(
                        builder: (BuildContext context,
                            StateSetter setStateForDialog) {
                          return SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                 Center(
                                  child: Text(
                                    AppLocalizations.of(context)?.pickYourImage??'',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
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
                                            context
                                                .read<GetImageToSetAvatarBloc>()
                                                .add(
                                                    GetImageToSetAvatarByGalleyEvent(
                                                        source: ImageSource
                                                            .gallery));
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
                                                        color:  ManagementColor.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child:  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            AppLocalizations.of(context)?.yourStorage??'',
                                                            style: const TextStyle(
                                                                color:
                                                                ManagementColor.grey,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
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
                                            context
                                                .read<GetImageToSetAvatarBloc>()
                                                .add(
                                                    GetImageToSetAvatarByGalleyEvent(
                                                        source: ImageSource
                                                            .camera));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: ManagementColor
                                                            .yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child:  Padding(
                                                      padding:
                                                          const EdgeInsets.all(5.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(context)?.yourCamera??'',
                                                            style: const TextStyle(
                                                                color:
                                                                ManagementColor.grey,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .camera_alt_outlined,
                                                            color: ManagementColor.grey,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  color: ManagementColor.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )),
                                    TextButton(
                                        onPressed: () async {
                                          context.read<ProfilePageBloc>().add(
                                              PostAvatarEvent(
                                                  currentImageName: widget
                                                          .currentUserInfo
                                                          .avatarUrl ??
                                                      '',
                                                  userId: widget
                                                      .currentUserInfo.userId,
                                                  file: _image!));
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
                                              AppLocalizations.of(context)?.updateAvatar??'',
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
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
