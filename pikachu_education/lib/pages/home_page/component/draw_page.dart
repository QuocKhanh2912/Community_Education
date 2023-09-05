import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/pages/authentication/login_page/bloc/login_page/login_bloc.dart';
import 'package:pikachu_education/pages/home_page/bloc/home_page/data_home_bloc.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/service/authentication/authentication_service.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




class DrawPageForHomePage extends StatefulWidget {
  const DrawPageForHomePage(
      {super.key, required this.currentUserInfo, required this.dataHomePageBloc});

  final DataUserModal currentUserInfo;
  final DataHomePageBloc dataHomePageBloc;

  @override
  State<DrawPageForHomePage> createState() => _DrawPageForHomePageState();
}


class _DrawPageForHomePageState extends State<DrawPageForHomePage> {
  final _authService = AuthenticationLocalService();

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
                iconTheme: const IconThemeData(size: 35,color: ManagementColor.black),
                foregroundColor: ManagementColor.black,
                activeIcon: Icons.close,
                backgroundColor: ManagementColor.yellow,
                buttonSize: const Size(50, 48),
                direction: SpeedDialDirection.down,
                children: [
                  SpeedDialChild(
                    backgroundColor: ManagementColor.red,
                    child: const Icon(Icons.people),
                    label: AppLocalizations.of(context)?.profile ??
                        '',
                    labelBackgroundColor: ManagementColor.yellow,
                    onTap: () {
                      Navigator.pushNamed(
                          context, PageName.profilePage,
                          arguments: widget.currentUserInfo);
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.logout),
                    labelBackgroundColor: ManagementColor.yellow,
                    label: AppLocalizations.of(context)?.logout ??
                        '',
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
