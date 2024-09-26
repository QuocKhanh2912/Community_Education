import 'package:flutter/cupertino.dart';

extension SubjectExtension on String {
  String autoEng(BuildContext context) {
    if (Localizations.localeOf(context).languageCode == 'vi') {}
    return this;
  }
}
