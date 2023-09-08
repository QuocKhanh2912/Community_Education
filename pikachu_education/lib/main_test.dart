import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/utils/extensions/data_user_extension.dart';

void main() {
  var a = '    quoc      khanh';
  var b = a
      .trim()
      .split(' ')
      .map((e) {
        if (e == ' ') {
          return '';
        }
        return e;
      })
      .toList()
      .join(' ');
  var c = a.trim().split(' ');
  c.removeWhere((element) {
    return element.isEmpty;
  });
  print(a.addAAAToString());
  print(a.trim());
  print(b);
  print(c.join(' Nguyen '));
  print(1.incre());
  print(1.incre().printContent());
  print(1.change());
  print(1.totalWith(2));
  print(DateTime.now());
  DataUserModal user = DataUserModal(
      userId: 'Khanh', userName: 'asd', email: 'asd', phoneNumber: '23453656');
  print(user.userInfo());
}

extension StringExtenstion on String {
  String addAAAToString() {
    return 'AAA$this';
  }
}

extension Increace on int {
  int incre() {
    return this + 1;
  }

  String printContent() {
    return 'this is: $this';
  }

  double change() {
    return this.toDouble();
  }

  int totalWith(int a) {
    return this + a;
  }
}
