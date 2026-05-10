import 'package:dio/dio.dart';
import 'package:lejos_de_casa_front/config/api_config.dart';
import 'package:lejos_de_casa_front/config/dio_cliente.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/infrastructure/models/casa/casa_model.dart';

class CasaData {
  Dio dio;
  CasaData(DioClient cliente) : dio = cliente.dio;

  Future<CasaModel> crearCasa(Map<String, dynamic> data) async {
    try {
      final res = await dio.post(ApiConfigCasas.crearCasa(), data: data);
      return CasaModel.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'Error al actualizar el usuario',
      );
    }
  }
  
  Future<List<CasaModel>> obtenerCasas({String? filtro,String? tipoFiltro}) async {
    try {
      if(filtro!=null){
        final res = await dio.get(ApiConfigCasas.obtenerCasasFiltro(filtro: filtro,tipoFiltro: tipoFiltro));
        final List data = res.data;
        return data.map((casa) => CasaModel.fromJson(casa)).toList();
      }else{
        final res = await dio.get(ApiConfigCasas.obtenerCasas());
        final List data = res.data;
        return data.map((casa) => CasaModel.fromJson(casa)).toList();

      }


    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'No se encontraron usuarios',
      );
    }
  }
}
