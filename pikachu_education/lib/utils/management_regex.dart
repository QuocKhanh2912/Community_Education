class ManagementRegex {
  static final RegExp phoneNumber = RegExp('^[+]?[0-9]{10,15}\$');
  static final RegExp otpCode = RegExp('^[+]?[0-9]{6}\$');
  static final RegExp email = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}