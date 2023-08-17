import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/bloc/bloc_login_page/login_bloc.dart';
import 'package:pikachu_education/components/positive_button.dart';
import 'package:pikachu_education/components/snack_bar_custom.dart';
import 'package:pikachu_education/components/text_form_field.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/service/service_local_storage/service_save_data_to_local_storage.dart';
import 'package:pikachu_education/utils/management_image.dart';
import 'package:pikachu_education/utils/management_key.dart';
import 'package:pikachu_education/utils/management_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'method_login.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final keyOfLogin = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = true;
  bool showPasswordIcon = true;
  final LoginBloc loginBloc = LoginBloc();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Future<void> loadDataForLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString(ManagementKey.user) ?? '';
    var password = prefs.getString(ManagementKey.password) ?? '';
    setState(() {
      phoneController.text = user;
      passwordController.text = password;
    });
  }

  @override
  void initState() {
    loginBloc.add(AutoLogin());
    loadDataForLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginBloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                var userId = state.userId;
                Navigator.pushNamed(context, PageName.homePage,
                    arguments: userId);
              }
              if (state is AutoLoginSuccessState) {
                var userId = state.userId;
                Navigator.pushNamed(context, PageName.homePage,
                    arguments: userId);
              }
            },
            child: WillPopScope(
              onWillPop: () {
                return SnackBarCustom.snackBarOfBack(context);
              },
              child: Scaffold(
                body: GestureDetector(
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
                                  hintText: 'phone',
                                  textEditingController: phoneController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'email can not be empty';
                                    }
                                    RegExp userExp = RegExp(
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                    if (!userExp!.hasMatch(value)) {
                                      return 'Your User is invalid';
                                    }
                                  },
                                  textInputType: TextInputType.text),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormFieldCustom(
                                textEditingController: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password can not be empty';
                                  }
                                  RegExp passwordExp = RegExp(
                                      '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,18}\$');
                                  if (!passwordExp.hasMatch(value)) {
                                    return 'Your Password is invalid';
                                  }
                                },
                                hintText: 'Password',
                                textInputType: TextInputType.text,
                                obscuringCharacter: '*',
                                turnObscuringCharacter: showPasswordIcon,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                        showPasswordIcon = !showPasswordIcon;
                                      });
                                    },
                                    icon: Icon(showPasswordIcon
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, PageName.getOtpPage);
                                        },
                                        child: const Text(
                                          'Forgot password?',
                                          style: TextStyle(
                                              fontSize: 15,
                                              decoration:
                                                  TextDecoration.underline),
                                        ))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              PositiveButtonCustom(nameButton: 'LOGIN',onPressed: (){
                                {
                                  keyOfLogin.currentState!.validate();
                                  if (keyOfLogin.currentState!
                                      .validate() ==
                                      true) {
                                    SaveDataToLocal.saveDataForLogin(
                                        context,
                                        phoneController.text,
                                        passwordController.text);
                                    context.read<LoginBloc>().add(
                                        LoginPressEvent(
                                            email: phoneController.text,
                                            password:
                                            passwordController.text,
                                            context: context));
                                  }
                                }
                              }),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('Or Login with',style: ManagementText.normalStyle),
                              const SizedBox(
                                height: 20,
                              ),
                              MethodLogin(iconMethod: ManagementImage.logoGoogle,nameMethod: 'Google',onTap: (){},),
                              const SizedBox(
                                height: 20,
                              ),
                              MethodLogin(iconMethod: ManagementImage.logoFacebook,nameMethod: 'Facebook',onTap: (){},),
                              const SizedBox(
                                height: 40,
                              ),

                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PageName.signupPage);
                                  },
                                  child: RichText(
                                    text: const TextSpan(children: [
                                      TextSpan(
                                          text: 'Don\'t have an accounts? ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                      TextSpan(
                                          text: 'Sign up now',
                                          style: TextStyle(
                                              color: Color(0xFFFDCA15),
                                              fontSize: 15))
                                    ]),
                                  )),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
