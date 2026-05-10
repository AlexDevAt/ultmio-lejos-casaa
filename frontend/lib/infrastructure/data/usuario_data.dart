import 'package:dio/dio.dart';
import 'package:lejos_de_casa_front/config/dio_cliente.dart';
import 'package:lejos_de_casa_front/infrastructure/models/usuario/usuario_model.dart';
import 'package:lejos_de_casa_front/config/api_config.dart';

class UsuarioData {
  Dio dio;

  UsuarioData(DioClient cliente) : dio = cliente.dio;

  Future<UsuarioModel> obtenerUsuario(String curp) async {
    try {
      final res = await dio.get(ApiConfigUsers.obtenerUsuario(curp));
      final data = res.data;
      return UsuarioModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Usuario no encontrado');
    }
  }

  Future<UsuarioModel> crearUsuario(Map<String, dynamic> data) async {
    try {
      final res = await dio.post(ApiConfigUsers.crearUsuario(), data: data);
      return UsuarioModel.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'Error al actualizar el usuario',
      );
    }
  }

  Future<UsuarioModel> actualizarUsuario(
    String curp,
    Map<String, dynamic> data,
  ) async {
    try {
      final res = await dio.patch(
        ApiConfigUsers.actualizarUsuario(curp),
        data: data,
      );
      return UsuarioModel.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'Error al actualizar el usuario',
      );
    }
  }

  Future<void> borrarUsuario(String curp) async {
    try {
      await dio.delete(ApiConfigUsers.actualizarUsuario(curp));
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'Error al borrar el usuario',
      );
    }
  }

  Future<List<UsuarioModel>> obtenerUsuarios() async {
    try {
      print(ApiConfigUsers.obtenerUsuarios());
      final res = await dio.get(ApiConfigUsers.obtenerUsuarios());
      final List data = res.data;
      return data.map((user) => UsuarioModel.fromJson(user)).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'No se encontraron usuarios',
      );
    }
  }
}
