import 'package:intl/intl.dart';

class FormatDate {
  static String formatDate(DateTime date) {
    String formato = 'dd/MM/yyyy';
    return DateFormat(formato).format(date);
  }
}
