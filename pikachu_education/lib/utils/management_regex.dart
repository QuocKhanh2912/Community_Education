class ManagementRegex {
  static RegExp phoneNumber = RegExp('^[+]?[0-9]{10,15}\$');
  static RegExp otpCode = RegExp('^[+]?[0-9]{6}\$');
  static RegExp email = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}