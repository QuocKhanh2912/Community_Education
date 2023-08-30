import 'package:flutter/material.dart';
import 'package:pikachu_education/utils/management_color.dart';

class PositiveButtonCustom extends StatelessWidget {
  const PositiveButtonCustom(
      {super.key,
      required this.nameButton,
      required this.onPressed,
      required this.stateLoading});

  final VoidCallback onPressed;
  final String nameButton;
  final bool stateLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
            backgroundColor: MaterialStateProperty.all(ManagementColor.yellow),
          ),
          onPressed: () => onPressed.call(),
          child: stateLoading
              ? const SizedBox(
                  height: 60,
                  child: Center(child: CircularProgressIndicator()))
              : SizedBox(
                  height: 60,
                  child: Center(
                    child: Text(
                      nameButton,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ManagementColor.white,
                          fontSize: 25),
                    ),
                  ),
                )),
    );
  }
}
