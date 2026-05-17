import 'package:intl/intl.dart';

class FormatDate {
  static String formatDate(DateTime date) {
    String formato = 'dd/MM/yyyy';
    return DateFormat(formato).format(date);
  }

  // static String formatDiferenciaTiempo(DateTime notiTiempoEnv) {
    


  // }

    static String formatDiferenciaTiempo(DateTime notiTiempoEnv) {
    final DateTime now = DateTime.now();
    final Duration diferencia = now.difference(notiTiempoEnv);

    if (diferencia.inSeconds < 60) {
      return 'Hace un momento';
    } else if (diferencia.inMinutes < 60) {
      return 'Hace ${diferencia.inMinutes} minutos';
    } else if (diferencia.inHours < 24) {
      return 'Hace ${diferencia.inHours} ${diferencia.inHours == 1 ? 'hora' : 'horas'}';
    } else if (diferencia.inDays == 1) {
      return 'Ayer';
    } else if (diferencia.inDays < 7) {
      return 'Hace ${diferencia.inDays} días';
    } else {
      return '${notiTiempoEnv.day}/${notiTiempoEnv.month}/${notiTiempoEnv.year}';
    }
  }
}
