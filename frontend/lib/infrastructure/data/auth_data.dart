import 'package:dio/dio.dart';
import 'package:lejos_de_casa_front/config/api_config.dart';
import 'package:lejos_de_casa_front/config/dio_cliente.dart';

class AuthData {
  Dio dio;

  AuthData(DioClient cliente) : dio = cliente.dio;

  Future<String> login(String email, String pass) async {
    try {
      final data = <String, dynamic>{'correo': email, 'password': pass};
      final res = await dio.post(ApiConfigAuth.iniciarSesion(), data: data);
      print(res.data);
      if (res.data == null) {
        throw ('Error al iniciar sesion');
      }
      return res.data['token'];
    } on DioException catch (e) {
      throw ('Error al iniciar sesion');
    }
  }
}
