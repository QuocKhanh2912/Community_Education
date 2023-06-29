import 'package:flutter/material.dart';
import 'package:pikachu_education/components/text_form_field_widget.dart';
import 'package:pikachu_education/data/data_image.dart';
import 'package:pikachu_education/routes/page_name.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final keyOfLogin = GlobalKey<FormState>();
  bool checkRememberMe = false;
  bool showPassword = true;
  bool showPasswordIcon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: keyOfLogin,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(logoImage.image),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'User',
                      hintStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'User can not be empty';
                    }
                    RegExp userExp =
                        RegExp('^[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}\$');
                    if (!userExp!.hasMatch(value)) {
                      return 'Your User is invalid';
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscuringCharacter: '*',
                  obscureText: showPassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.white,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password can not be empty';
                    }
                    RegExp passwordExp = RegExp(
                        '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,18}\$');
                    if (!passwordExp!.hasMatch(value)) {
                      return 'Your Password is invalid';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PageName.getOtpPage);
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(fontSize: 15),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 13,
                    color: Colors.transparent,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.yellow),
                        ),
                        onPressed: () {
                          keyOfLogin.currentState!.validate();
                          if (keyOfLogin.currentState!.validate() == true) {
                            Navigator.pushNamed(context, PageName.answerPage);
                          }
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12, right: 8),
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, PageName.signupPage);
                    },
                    child: const Text(
                      'Do not have an account? SIGN UP',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12, right: 8),
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, PageName.answerPage);
                    },
                    child: Text('View Answer')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12, right: 8),
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, PageName.changePasswordPage);
                    },
                    child: Text('change password')),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
