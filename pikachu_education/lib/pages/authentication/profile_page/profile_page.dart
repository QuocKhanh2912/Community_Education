import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/domain/repositories/database_repositories.dart';
import 'package:pikachu_education/utils/management_image.dart';
import 'bloc/profile_page/profile_page_bloc.dart';
import 'component/get_image_to_set_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.currentUserInfo});

  final DataUserModal currentUserInfo;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isPassOb = true;
  DataUserModal currentUserInfo =
  DataUserModal(
      userId: 'userId', userName: 'userName', email: 'email', avatarUrl: '');
  getCurrentUserInfo(String userID) async {
    var currentUserFromDataBase =
    await DatabaseRepositories.getCurrentUserInfo(userID: userID);
    setState(() {
      currentUserInfo = currentUserFromDataBase;
    });
  }
  @override
  void initState() {
    getCurrentUserInfo(widget.currentUserInfo.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageBloc(),
      child: BlocListener<ProfilePageBloc, ProfilePageState>(
        listener: (context, state) {
          if(state is PostAvatarSuccess){
            setState(() {

            });
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Edit profile'),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
            ),
            body: Container(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                BorderRadius.all(Radius.circular(130))),
                            child: widget.currentUserInfo.avatarUrl == ''
                                ? ClipRRect(
                                borderRadius: BorderRadius.circular(130),
                                child: Image.asset(
                                  ManagementImage.defaultAvatar,
                                  fit: BoxFit.fill,
                                ))
                                : ClipRRect(
                                borderRadius: BorderRadius.circular(130),
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
                                    border:
                                    Border.all(width: 4, color: Colors.white),
                                    color: Colors.yellow),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          GetImageToSetAvatar(
                                              currentUserInfo: widget
                                                  .currentUserInfo),
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
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    buildTextField(
                        'User Name', widget.currentUserInfo.userName, true),
                    buildTextField(
                        'Email', widget.currentUserInfo.email, false),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                            'Cancel'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 15,
                                letterSpacing: 2,
                                color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                            'Save'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 15,
                                letterSpacing: 2,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool enableEdit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
            enabled: enableEdit),
      ),
    );
  }
}
