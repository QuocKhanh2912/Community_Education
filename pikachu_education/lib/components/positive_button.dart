import 'package:flutter/material.dart';
import 'package:pikachu_education/utils/management_color.dart';

class PositiveButtonCustom extends StatelessWidget {
  const PositiveButtonCustom(
      {super.key, required this.nameButton, required this.onPressed,required this.stateLoading});

  final VoidCallback onPressed;
  final String nameButton;
  final bool stateLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          color: Colors.transparent,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ManagementColor.yellow),
              ),
              onPressed: () => onPressed.call(),
              child: stateLoading? const Center(
                  child: CircularProgressIndicator()): Text(
                nameButton,
                style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ManagementColor.white,
                    fontSize: 25),
              )),
        ),
      ),
    );
  }
}
