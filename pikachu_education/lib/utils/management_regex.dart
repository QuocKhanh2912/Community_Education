class ManagementRegex {
  static RegExp phoneNumber = RegExp('^[+]?[0-9]{10,15}\$');
  static RegExp otpCode = RegExp('^[+]?[0-9]{6}\$');
}