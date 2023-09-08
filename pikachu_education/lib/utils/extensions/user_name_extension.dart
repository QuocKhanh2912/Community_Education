extension UserNameExtension on String {
  String removeSpaces() {
    return trim().replaceAll(RegExp(r'\s+'), ' ');
  }
}
