import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/pages/authentication/login_page/component/bloc_login_page/login_bloc.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:pikachu_education/utils/management_image.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final loginBloc = LoginBloc();

  @override
  void initState() {
    loginBloc.add(LoginAutoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
         if(state is AutoLoginSuccessState){
           Navigator.pushNamed(context, PageName.homePage,arguments: state.userId);
         }
         if(state is LoginUnSuccessState){
           Navigator.pushNamed(context, PageName.loginPage);
         }
        },
        child: Scaffold(
          backgroundColor: ManagementColor.white,
          body: SafeArea(
            child: Column(children: [
              Expanded(child: Image.asset(ManagementImage.logo)),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Center(child: CircularProgressIndicator()),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
