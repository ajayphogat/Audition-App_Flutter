import 'package:intl/intl.dart';

class TimeAgo {
  static String timeAgoSinceDate(int time) {
    DateTime messageDate = DateTime.fromMillisecondsSinceEpoch(time);

    final date2 = DateTime.now();

    final diff = date2.difference(messageDate);

    if (diff.inDays > 8)
      return DateFormat("dd/MM/yyyy").format(messageDate);
    else if ((diff.inDays / 7).floor() >= 1)
      return 'Last Week';
    else if (diff.inDays >= 2)
      return '${diff.inDays} days';
    else if (diff.inDays >= 1)
      return '1 day';
    else if (diff.inHours >= 2)
      return '${diff.inHours} hr';
    else if (diff.inHours >= 1)
      return '1 hr';
    else if (diff.inMinutes >= 2)
      return '${diff.inMinutes} min';
    else if (diff.inMinutes >= 1)
      return '1 min';
    else if (diff.inSeconds >= 3)
      return '${diff.inSeconds} sec';
    else
      return 'Just now';
  }
}
