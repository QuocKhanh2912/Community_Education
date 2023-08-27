import 'package:flutter/material.dart';
import '../../../routes/page_name.dart';

class DialogCustom {
  static dialogOfPostAnswer(BuildContext context) {
    return AlertDialog(
      title: const Text('Post Answer'),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent)),
      content: const Text('You have to login to do this action'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PageName.loginPage);
                  },
                  child: const Text('Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  static dialogOfInvalidEmail(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFFFFFFF),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: const Text('The Email is Invalid',
          style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black)),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xFFFDCA15),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text('OK',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white)),
              ),
            ))
      ],
    );
  }

  static dialogOfWrongPassword(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFFFFFFF),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: const Text('The Password or Email is Invalid',

          style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black)),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xFFFDCA15),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text('OK',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white)),
              ),
            ))
      ],
    );
  }

  static dialogOfWrongPhoneNumber(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFFFFFFF),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: const Text('The Phone Number is Invalid',

          style: TextStyle(
            //fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black)),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xFFFDCA15),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text('OK',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white)),
              ),
            ))
      ],
    );
  }

  static wrongOTPCode(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFFFFFFF),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: const Text('OPT Code Is\'nt True',

          style: TextStyle(
            //fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black)),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xFFFDCA15),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text('OK',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white)),
              ),
            ))
      ],
    );
  }

  static autoLoginFalse(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFFFFFFF),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: const Text('Auto Login False, please enter Email and Password to login again',
          style: TextStyle(
            //fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black)),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xFFFDCA15),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text('OK',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white)),
              ),
            ))
      ],
    );
  }

  static falseLogout(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFFFFFFF),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: const Text('SomeThing Wrong',

          style: TextStyle(
            //fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black)),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xFFFDCA15),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text('OK',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white)),
              ),
            ))
      ],
    );
  }
}
