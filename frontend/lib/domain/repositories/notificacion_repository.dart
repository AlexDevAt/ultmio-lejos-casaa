import 'package:lejos_de_casa_front/domain/entities/notificacion.dart';

abstract class NotificacionRepository {
  Future<List<NotificacionEnty>> obtenerNotificaciones();
}
