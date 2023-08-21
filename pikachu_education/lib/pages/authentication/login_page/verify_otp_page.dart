import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/bloc/bloc_login_page/login_bloc.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/service/service_login/firebase_login_by_phone_number.dart';

import '../../../utils/management_image.dart';

class VerifyOTPPage extends StatefulWidget {
  const VerifyOTPPage({super.key, required this.verification});

  final String verification;

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final keyVerify = GlobalKey<FormState>();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is VerifyOTPSuccessState) {
            Navigator.pushNamed(context, PageName.homePage,arguments: state.userId);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Scaffold(
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: keyVerify,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back, size: 30)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Image.asset(ManagementImage.logo),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       top: 65, left: 10, right: 10),
                            //   child: Image.asset(
                            //       'assets/image/time_line_step_2.png'),
                            // ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 60, left: 10, right: 10),
                              child: Text('Verification',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 45, left: 10, right: 10),
                              child: Text(
                                  textAlign: TextAlign.center,
                                  'Please enter your email and press GET OTP button, an OPT code will be send your email',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 60, left: 10, right: 10),
                              child: TextFormField(
                                controller: otpController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Enter OTP Code',
                                    hintStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0x4D000000)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fillColor: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'OTP can not be empty';
                                  }
                                  RegExp otpExp = RegExp('^[+]?[0-9]{6}\$');
                                  if (!otpExp!.hasMatch(value)) {
                                    return 'OTP is invalid';
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 70, left: 10, right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  color: Colors.transparent,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color(0xFFFDCA15)),
                                      ),
                                      onPressed: () {
                                        keyVerify.currentState!.validate();
                                        if (keyVerify.currentState!
                                                .validate() ==
                                            true) {
                                          context.read<LoginBloc>().add(
                                              VerifyOtpEvent(
                                                  otpNumber: otpController.text,
                                                  context: context,
                                                  verificationId:
                                                      widget.verification));
                                        }
                                      },
                                      child: state is VerifyOTPLoadingState? const Center(
                                      child: CircularProgressIndicator()) : const Text(
                                        'VERIFY',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 25),
                                      )),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
