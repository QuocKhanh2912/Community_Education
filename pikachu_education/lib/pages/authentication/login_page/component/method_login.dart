import 'package:flutter/material.dart';
import 'package:pikachu_education/utils/management_text_style.dart';

class MethodLogin extends StatelessWidget {
  const MethodLogin(
      {super.key,
      required this.iconMethod,
      required this.nameMethod,
      required this.onTap});

  final String iconMethod;
  final String nameMethod;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () => onTap.call(),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconMethod),
          const SizedBox(width: 5),
          Text(
            'Login with $nameMethod',
            style: ManagementTextStyle.methodLogin,
          )
        ],
      ),
    );
  }
}
