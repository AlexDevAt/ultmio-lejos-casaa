import 'package:lejos_de_casa_front/domain/entities/notificacion.dart';
import 'package:lejos_de_casa_front/domain/repositories/notificacion_repository.dart';

class NotificacionService {
  final NotificacionRepository repo;
  NotificacionService(this.repo);

  Future<List<NotificacionEnty>> obtenerNotificaciones(String curp) async {
    final notis = await repo.obtenerNotificaciones(curp);
    if (notis.isEmpty) return [];
    return notis;
  }
}
