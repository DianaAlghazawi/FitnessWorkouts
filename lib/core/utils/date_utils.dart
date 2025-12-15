import 'package:intl/intl.dart';

class DateUtils {
  static String formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String formatDateTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('MMM dd, yyyy HH:mm').format(date);
  }

  static int getCurrentTimestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
