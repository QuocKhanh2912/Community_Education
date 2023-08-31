import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/components/button/negative_button.dart';
import 'package:pikachu_education/components/button/positive_button.dart';
import 'package:pikachu_education/components/text_form_field.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/service/authentication/authentication_service.dart';
import 'package:pikachu_education/utils/management_image.dart';
import 'package:pikachu_education/utils/management_regex.dart';

import 'bloc/profile_page/profile_page_bloc.dart';
import 'component/get_image_to_set_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.currentUserInfo});

  final DataUserModal currentUserInfo;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final keyOfProfile = GlobalKey<FormState>();
  String methodLogin = '';
  final ProfilePageBloc profilePageBloc = ProfilePageBloc();

  @override
  void dispose() {
    userNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    profilePageBloc.add(FetchProfilePageData(widget.currentUserInfo.userId));
    //Todo: should use LoginBloc instead
    // AuthenticationLocalService.methodLoginCurrent().then((value) {
    //   setState(() {
    //     methodLogin = value;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profilePageBloc,
      child: BlocListener<ProfilePageBloc, ProfilePageState>(
        listener: (context, state) {
          if (state is PostAvatarSuccess) {
            setState(() {});
          }
        },
        child: Scaffold(
            body: BlocListener<ProfilePageBloc, ProfilePageState>(
          listener: (context, state) {
            if (state is PostAvatarSuccess ||
                state is UpdateProfileSuccessState) {
              context
                  .read<ProfilePageBloc>()
                  .add(RefreshProfilePage(widget.currentUserInfo.userId));
            }
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Form(
                  key: keyOfProfile,
                  child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
                    builder: (context, state) {
                      if (state is FetchProfileInfoSuccessState) {
                        var currentUserInfo = state.currentUserInfo;
                        userNameController.text = currentUserInfo.userName;
                        phoneNumberController.text =
                            currentUserInfo.phoneNumber ?? '';
                        emailController.text = currentUserInfo.email;
                        return Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Icon(Icons.arrow_back_outlined),
                                  )),
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 130,
                                  height: 130,
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(130))),
                                  child: widget.currentUserInfo.avatarUrl == ''
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(130),
                                          child: Image.asset(
                                            ManagementImage.defaultAvatar,
                                            fit: BoxFit.fill,
                                          ))
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(130),
                                          child: Image.network(
                                            widget.currentUserInfo.avatarUrl!,
                                            fit: BoxFit.fill,
                                          )),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 4, color: Colors.white),
                                          color: Colors.yellow),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                GetImageToSetAvatar(
                                                    currentUserInfo:
                                                        widget.currentUserInfo),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.photo_camera,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormFieldCustom(
                                textEditingController: userNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'User Name can not be empty';
                                  }
                                },
                                hintText: 'User Name',
                                textInputType: TextInputType.text,
                                textLabel: 'User Name'),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormFieldCustom(
                                enabled: methodLogin == 'byPhoneNumber'
                                    ? false
                                    : true,
                                textEditingController: phoneNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Phone Number can not be empty';
                                  }
                                  RegExp phoneNumExp =
                                      ManagementRegex.phoneNumber;
                                  if (!phoneNumExp.hasMatch(value)) {
                                    return 'Your Phone Number is invalid';
                                  }
                                },
                                hintText: 'Phone Number',
                                textInputType: TextInputType.phone,
                                textLabel: 'Phone Number'),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormFieldCustom(
                                enabled: methodLogin == 'byGoogle' ||
                                        methodLogin == 'byFacebook'
                                    ? false
                                    : true,
                                textEditingController: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email can not be empty';
                                  }
                                  RegExp phoneNumExp = ManagementRegex.email;
                                  if (!phoneNumExp.hasMatch(value)) {
                                    return 'Your Email Number is invalid';
                                  }
                                },
                                hintText: 'Email',
                                textInputType: TextInputType.text,
                                textLabel: 'Email'),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const NegativeButtonCustom(
                                      nameButton: 'Cancel'),
                                  PositiveButtonCustom(
                                      onPressed: () {
                                        var validator = keyOfProfile
                                            .currentState!
                                            .validate();
                                        if (validator) {
                                          DataUserModal item = DataUserModal(
                                              userId: currentUserInfo.userId,
                                              userName: userNameController.text,
                                              email: emailController.text,
                                              phoneNumber:
                                                  phoneNumberController.text);
                                          context.read<ProfilePageBloc>().add(
                                              UpdateProfileEvent(
                                                  itemToUpdate: item));
                                        }
                                      },
                                      nameButton: '  Save  ',
                                      stateLoading:
                                          (state is UpdateProfileLoadingState)
                                              ? true
                                              : false),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
