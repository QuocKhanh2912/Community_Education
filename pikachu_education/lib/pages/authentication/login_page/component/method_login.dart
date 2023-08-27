import 'package:flutter/material.dart';
import 'package:pikachu_education/utils/management_text_style.dart';

class MethodLogin extends StatelessWidget {
  const MethodLogin(
      {super.key,
      required this.iconMethod,
      required this.onTap});

  final String iconMethod;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () => onTap.call(),
      child: Image.asset(iconMethod),
    );
  }
}
