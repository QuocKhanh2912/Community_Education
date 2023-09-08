import 'package:pikachu_education/data/modal/user_modal.dart';

extension UserExtension on DataUserModal{
  String userInfo (){
    return 'My name ${this.userName} and my number ${this.phoneNumber}';
  }
}