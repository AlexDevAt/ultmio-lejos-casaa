import 'package:lejos_de_casa_front/domain/entities/notificacion.dart';
import 'package:lejos_de_casa_front/domain/repositories/notificacion_repository.dart';
import 'package:lejos_de_casa_front/infrastructure/data/notificacion_data.dart';

class NotificacionRepositoryImpl extends NotificacionRepository {
  final NotificacionData dataSource;
  NotificacionRepositoryImpl(this.dataSource);

  @override
  Future<List<NotificacionEnty>> obtenerNotificaciones(String curp) async {
    final models = await dataSource.obtenerNotificacionesLeidas(curp);
    return models.map((notiModel) => notiModel.toEntity()).toList();
  }
}
