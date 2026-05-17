import 'package:dio/dio.dart';
import 'package:lejos_de_casa_front/config/api_config.dart';
import 'package:lejos_de_casa_front/config/dio_cliente.dart';
import 'package:lejos_de_casa_front/infrastructure/models/notificacion/notificacion_model.dart';

class NotificacionData {
  Dio dio;

  NotificacionData(DioClient diocliente) : dio = diocliente.dio;

  Future<List<NotificacionModel>> obtenerNotificacionesLeidas(String curp) async {
    try {
      final res = await dio.get(
        ApiConfigNotificaciones.obtenerNotificaciones(curp),
      );
      final List data = res.data;
      if (data.isEmpty) return [];
      return data.map((noti) => NotificacionModel.fromJson(noti)).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'No se encontraron resenias',
      );
    }
  }
}
