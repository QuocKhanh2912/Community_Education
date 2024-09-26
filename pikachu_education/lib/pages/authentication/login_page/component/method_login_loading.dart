import 'package:flutter/material.dart';
import 'package:pikachu_education/utils/management_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MethodLoginLoading extends StatelessWidget {
  const MethodLoginLoading(
      {super.key});


  @override
  Widget build(BuildContext context) {
    return  Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(width: 5),
        Text(
          AppLocalizations.of(context)?.pleaseWaiting??'',
          style: ManagementTextStyle.methodLogin,
        )
      ],
    );
  }
}
