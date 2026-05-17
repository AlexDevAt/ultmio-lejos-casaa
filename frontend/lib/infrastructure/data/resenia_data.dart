import 'package:dio/dio.dart';
import 'package:lejos_de_casa_front/config/api_config.dart';
import 'package:lejos_de_casa_front/config/dio_cliente.dart';
import 'package:lejos_de_casa_front/infrastructure/models/resenia/resenia_model.dart';

class ReseniaData {
  Dio dio;

  ReseniaData(DioClient diocliente) : dio = diocliente.dio;

  Future<List<ReseniaModel>> obtenerReseniasCasa(dynamic idCasa) async {
    try {
      final res = await dio.get(ApiConfigResenia.obtenerReseniasCasa(idCasa));
      final List data = res.data;
      return data.map((e) => ReseniaModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'No se encontraron resenias',
      );
    }
  }
}
