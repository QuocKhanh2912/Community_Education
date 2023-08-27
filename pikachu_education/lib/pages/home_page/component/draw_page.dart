import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pikachu_education/data/data_modal/data_user_modal.dart';
import 'package:pikachu_education/pages/authentication/login_page/component/bloc_login_page/login_bloc.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'bloc_home_page/data_home_bloc.dart';


class DrawPageForHomePage extends StatefulWidget {
  const DrawPageForHomePage(
      {super.key, required this.currentUserInfo, required this.dataHomePageBloc});

  final DataUserModal currentUserInfo;
  final DataHomePageBloc dataHomePageBloc;

  @override
  State<DrawPageForHomePage> createState() => _DrawPageForHomePageState();
}

class _DrawPageForHomePageState extends State<DrawPageForHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.dataHomePageBloc,
      child: BlocBuilder<DataHomePageBloc, DataHomePageState>(
        builder: (context, state) {
          return Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding:
              const EdgeInsets.only(top: 1, right: 8),
              child: SpeedDial(
                icon: Icons.menu,
                iconTheme: const IconThemeData(size: 35),
                foregroundColor: Colors.black,
                activeIcon: Icons.close,
                backgroundColor: const Color(0xFFFDCA15),
                buttonSize: const Size(50, 48),
                direction: SpeedDialDirection.down,
                children: [
                  SpeedDialChild(
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.people),
                    label: 'Profile',
                    labelBackgroundColor: const Color(0xFFFDCA15),
                    onTap: () {
                      Navigator.pushNamed(
                          context, PageName.profilePage,
                          arguments: widget.currentUserInfo);
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.logout),
                    labelBackgroundColor: const Color(0xFFFDCA15),
                    label: 'Logout',
                    onTap: () async {
                      context.read<LoginBloc>().add(LogoutEvent());
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
