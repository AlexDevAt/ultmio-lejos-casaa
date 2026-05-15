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
      return data.map((reserva) {
        return ReservaModel.fromJson(reserva);
      }).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'No se encontraron reservas',
      );
    }
  }
}
