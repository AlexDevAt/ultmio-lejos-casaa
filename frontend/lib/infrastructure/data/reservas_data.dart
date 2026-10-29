import 'package:dio/dio.dart';
import 'package:lejos_de_casa_front/config/api_config.dart';
import 'package:lejos_de_casa_front/config/dio_cliente.dart';
import 'package:lejos_de_casa_front/infrastructure/models/reserva/reserva_model.dart';

class ReservasData {
  Dio dio;

  ReservasData(DioClient cliente) : dio = cliente.dio;

  Future<List<ReservaModel>> obtenerReservasUsuario(String curp) async {
    try {
      final res = await dio.get(ApiConfigReservas.obtenerReservas(curp));
      final List data = res.data;
      return data.map((reserva) =>  ReservaModel.fromJson(reserva)).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'No se encontraron reservas',
      );
    }
  }

  Future<ReservaModel> reservarCasa(int idCasa, String idComprador) async {
    final Map<String, dynamic> body = {
      "id_reserva":-1,
      "fecha_inicio": "2026-05-15T21:42:58.770Z",
      "fecha_fin": "2026-05-15T21:42:58.771Z",
      "estado": "Activo",
      "idCasa": idCasa,
      "idComprador": idComprador,
    };

    try {
      final res = await dio.post(
        ApiConfigReservas.crearReserva(idCasa, idComprador),
        data: body,
      );
      final data = res.data;       
      return ReservaModel.fromJson(data);
    } on DioException catch (e) {
      String mensajeError = 'Error al reservar';
    //   if (e.response != null) {
    //   // Extraemos el detalle que configuraste en FastAPI: {"detail": "..."}
    //   mensajeError = e.response?.data['detail'] ?? "Error en el servidor (${e.response?.statusCode})";
    // } else {
    //   mensajeError = "No se pudo conectar con el servidor";
    // }
    throw (mensajeError);
    }
  }
}
