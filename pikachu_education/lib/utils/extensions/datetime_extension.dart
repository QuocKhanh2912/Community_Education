import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

extension DateTimeExtension on String {
  String formatDateTime(BuildContext context) {
    DateTime? dateTime = DateTime.tryParse(this);
    if (dateTime != null) {
      if (Localizations.localeOf(context).languageCode == 'vi') {
        String formattedDate = DateFormat('dd/MM/yyyy', 'vi_VN').format(dateTime);
        String formattedTime = DateFormat('HH:mm').format(dateTime);
        return '$formattedDate lúc $formattedTime';
      } else {
        String formattedDate = DateFormat('MMM-dd-yyyy').format(dateTime);
        String formattedTime = DateFormat('HH:mm').format(dateTime);
        return '$formattedDate at $formattedTime';
      }
    } else {
      return '';
    }
  }
}