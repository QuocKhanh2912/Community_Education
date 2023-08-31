import 'package:flutter/material.dart';
import 'package:pikachu_education/utils/management_text_style.dart';

class MethodLoginLoading extends StatelessWidget {
  const MethodLoginLoading(
      {super.key});


  @override
  Widget build(BuildContext context) {
    return const Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(width: 5),
        Text(
          'Please waiting',
          style: ManagementTextStyle.methodLogin,
        )
      ],
    );
  }
}
