
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DataAddQuestion {
  static List<String> listSubject(BuildContext context) {
    return [
      AppLocalizations.of(context)?.subject ?? '',
      AppLocalizations.of(context)?.mathematics ?? '',
      AppLocalizations.of(context)?.literature ?? '',
      AppLocalizations.of(context)?.foreignLanguage ?? '',
      AppLocalizations.of(context)?.history ?? '',
      AppLocalizations.of(context)?.physicalEducation ?? '',
      AppLocalizations.of(context)?.chemistry ?? '',
      AppLocalizations.of(context)?.technology?? '',
      AppLocalizations.of(context)?.music ?? '',
      AppLocalizations.of(context)?.biology ?? '',
      AppLocalizations.of(context)?.civicEducation ?? '',
      AppLocalizations.of(context)?.fineArt ?? '',
      AppLocalizations.of(context)?.engineering ?? '',
      AppLocalizations.of(context)?.english ?? '',
      AppLocalizations.of(context)?.informatics ?? '',
      AppLocalizations.of(context)?.other ?? '',
    ];
  }
}
