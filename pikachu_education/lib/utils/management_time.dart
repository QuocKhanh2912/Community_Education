import 'package:intl/intl.dart';

class ManagementTime {
  static String getTimePost() {
    final DateTime getTimeDay = DateTime.now();
    final DateFormat formatterDay = DateFormat('yMMMd');
    final DateFormat formatterTime = DateFormat('Hm');
    final String today = formatterDay.format(getTimeDay);
    final String time = formatterTime.format(getTimeDay);
    final String timePost = '$today at $time';

    return timePost;
  }
}
