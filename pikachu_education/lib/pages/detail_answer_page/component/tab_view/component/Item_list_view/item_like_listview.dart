import 'package:flutter/material.dart';
import 'package:pikachu_education/data/data_modal/data_user_modal.dart';
import 'package:pikachu_education/domain/repositories/database_repositories.dart';
import 'package:pikachu_education/domain/services/database_service/database_service.dart';
import 'package:pikachu_education/utils/management_image.dart';


class ItemLikeListView extends StatefulWidget {
  const ItemLikeListView({super.key, required this.userId});

  final String userId;

  @override
  State<ItemLikeListView> createState() => _ItemLikeListViewState();
}

class _ItemLikeListViewState extends State<ItemLikeListView> {
  DataUserModal userLiked = DataUserModal(
      userId: 'userId', userName: 'userName', email: 'email', avatarUrl: '');

  getCurrentUserInfo(String userID) async {
    var currentUserFromDataBase =
        await DatabaseRepositories.getCurrentUserInfo(userID: userID);
    setState(() {
      userLiked = currentUserFromDataBase;
    });
  }

  @override
  void initState() {
    getCurrentUserInfo(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('okokokoko $userLiked');
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xFFFDFFAE), Color(0xFFFFFFFF)])),
      child: Row(children: [
        userLiked.avatarUrl == ''
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset(ManagementImage.defaultAvatar,fit: BoxFit.fill,)),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.network(userLiked.avatarUrl!,fit: BoxFit.fill)),
              ),
         Text(userLiked.userName)
      ]),
    );
  }
}
