import 'package:flutter/material.dart';
import 'package:pikachu_education/utils/management_color.dart';

class NegativeButtonCustom extends StatelessWidget {
  const NegativeButtonCustom(
      {super.key, required this.nameButton,});

  final String nameButton;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
            backgroundColor: MaterialStateProperty.all(ManagementColor.white),
          ),
          onPressed: () => Navigator.pop(context),
          child:  SizedBox(
            height: 60,
            child: Center(
              child: Text(
                nameButton,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ManagementColor.black,
                    fontSize: 25),
              ),
            ),
          )),
    );
  }
}
