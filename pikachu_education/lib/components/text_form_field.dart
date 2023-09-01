import 'package:flutter/material.dart';
import 'package:pikachu_education/utils/management_color.dart';

class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom(
      {super.key,
      required this.textEditingController,
      required this.validator,
      required this.hintText,
      required this.textInputType,
       this.obscuringCharacter,
       this.turnObscuringCharacter,this.suffixIcon,this.textLabel,this.enabled});

  final TextEditingController textEditingController;
  final Function(String?) validator;
  final String hintText;
  final TextInputType textInputType;
  final String? obscuringCharacter;
  final bool? turnObscuringCharacter;
  final IconButton? suffixIcon;
  final String? textLabel;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        enabled: enabled,
        keyboardType: textInputType,
        controller: textEditingController,
        obscuringCharacter: obscuringCharacter??'*',
        obscureText: turnObscuringCharacter??false,
        decoration: InputDecoration(
          labelText: textLabel,
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(0x4D000000)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: ManagementColor.white,
        suffixIcon: suffixIcon),
        validator: (value) => validator(value),
      ),
    );
  }
}
