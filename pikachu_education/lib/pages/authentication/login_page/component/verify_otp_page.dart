import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/components/text_form_field.dart';
import 'package:pikachu_education/pages/authentication/component/dialog_custom.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:pikachu_education/utils/management_image.dart';
import 'package:pikachu_education/utils/management_regex.dart';
import 'package:pikachu_education/utils/management_text_inform.dart';
import 'bloc_login_page/login_bloc.dart';


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
          if (state is LoginVerificationOTPSuccessState) {
            Navigator.pushNamed(context, PageName.homePage,
                arguments: state.userId);
          }
          if (state is LoginVerificationOTPUnSuccessState){
            showDialog(context: context, builder: (context) => DialogCustom.wrongOTPCode(context));
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
                              padding: const EdgeInsets.only(left: 10, top: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.arrow_back, size: 30)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Image.asset(ManagementImage.logo),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 60, left: 10, right: 10),
                              child: Text('Verification',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                             Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                  textAlign: TextAlign.center,
                                  ManagementTextInform.informOTP,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormFieldCustom(
                                textEditingController: otpController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'OTP can not be empty';
                                  }
                                  RegExp otpExp = ManagementRegex.otpCode;
                                  if (!otpExp.hasMatch(value)) {
                                    return 'OTP is invalid';
                                  }
                                },
                                hintText: 'Enter OTP Code',
                                textInputType: TextInputType.number),
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        ManagementColor.yellow),
                                    shape: MaterialStateProperty.all(
                                        ContinuousRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                  ),
                                  onPressed: () {
                                    keyVerify.currentState!.validate();
                                    if (keyVerify.currentState!.validate() ==
                                        true) {
                                      context.read<LoginBloc>().add(
                                          LoginVerifyOtpEvent(
                                              otpNumber: otpController.text,
                                              context: context,
                                              verificationId:
                                                  widget.verification));
                                    }
                                  },
                                  child: state is LoginVerificationOTPLoadingState
                                      ? SizedBox(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        )
                                      : SizedBox(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: const Center(
                                            child: Text(
                                              'VERIFY',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        )),
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
