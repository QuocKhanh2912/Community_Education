class ManagementRegex {
  static final RegExp phoneNumber = RegExp('^[+]?[0-9]{10,15}\$');
  static final RegExp otpCode = RegExp('^[+]?[0-9]{6}\$');
  static final RegExp email = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp userName = RegExp(
      r'^(?=[a-zA-Z0-9. ]{8,25}$)(?!.*[_.]{2})[^_.].*[^_.]$|^[a-zA-Z0-9. áàảãạăắằẳẵặâấầẩẫậđéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵ]{8,25}$');
}
