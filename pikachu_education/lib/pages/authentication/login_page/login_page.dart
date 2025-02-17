import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/components/button/positive_button.dart';
import 'package:pikachu_education/components/text_form_field.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/utils/management_image.dart';
import 'package:pikachu_education/utils/management_regex.dart';
import 'package:pikachu_education/utils/management_text_style.dart';

import 'bloc/login_page/login_bloc.dart';
import 'component/method_login.dart';
import 'component/method_login_loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final keyOfLogin = GlobalKey<FormState>();

  final LoginBloc loginBloc = LoginBloc();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      phoneNumberController.text = '+84';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is AutoLoginSuccessState) {
                    var userId = state.userId;
                    Navigator.pushNamed(context, PageName.homePage,
                        arguments: userId);
                  } else if (state is LoginWithGoogleSuccessState) {
                    var userId = state.userId;
                    Navigator.pushNamed(context, PageName.homePage,
                        arguments: userId);
                  } else if (state is LoginWithFacebookSuccessState) {
                    var userId = state.userId;
                    Navigator.pushNamed(context, PageName.homePage,
                        arguments: userId);
                  } else if (state is LoginWithPhoneNumSuccessState) {
                    Navigator.pushNamed(context, PageName.verifyPage);
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Form(
                        key: keyOfLogin,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 100),
                              Image.asset(ManagementImage.logo),
                              const SizedBox(height: 60),
                              TextFormFieldCustom(
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
                                  textInputType: TextInputType.phone),
                              const SizedBox(
                                height: 40,
                              ),
                              PositiveButtonCustom(
                                  stateLoading:
                                      state is LoginWithPhoneNumLoadingState
                                          ? true
                                          : false,
                                  nameButton: 'LOGIN',
                                  onPressed: () {
                                    {
                                      keyOfLogin.currentState!.validate();
                                      if (keyOfLogin.currentState!.validate() ==
                                          true) {
                                        context.read<LoginBloc>().add(
                                            LoginWithPhoneNumEvent(
                                                phoneNum:
                                                    phoneNumberController.text,
                                                context: context));
                                      }
                                    }
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Or Login with',
                                  style: ManagementTextStyle.normalStyle),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  state is LoginWithGoogleLoadingState
                                      ? const MethodLoginLoading()
                                      : MethodLogin(
                                          iconMethod:
                                              ManagementImage.logoGoogle,
                                          onTap: () {
                                            context
                                                .read<LoginBloc>()
                                                .add(LoginWithGoogleEvent());
                                          },
                                        ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  state is LoginWithFacebookLoadingState
                                      ? const MethodLoginLoading()
                                      : MethodLogin(
                                    iconMethod:
                                    ManagementImage.logoFacebook,
                                    onTap: () {
                                      context
                                          .read<LoginBloc>()
                                          .add(LoginWithFacebookEvent());
                                    },
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
