import 'package:lejos_de_casa_front/app/services/casa_service.dart';
import 'package:lejos_de_casa_front/app/services/usuario_service.dart';
import 'package:lejos_de_casa_front/config/dio_cliente.dart';
import 'package:lejos_de_casa_front/domain/repositories/casa_repository.dart';
import 'package:lejos_de_casa_front/domain/repositories/usuario_repository.dart';
import 'package:lejos_de_casa_front/infrastructure/data/casa_data.dart';
import 'package:lejos_de_casa_front/infrastructure/data/usuario_data.dart';
import 'package:lejos_de_casa_front/infrastructure/repositories/casa/casa_repository_impl.dart';
import 'package:lejos_de_casa_front/infrastructure/repositories/usuario/usuario_repository_impl.dart';

class Di {
  
  static UsuarioService createUsuarioService() {
    DioClient dioClient = DioClient();
    UsuarioData usuarioData = UsuarioData(dioClient);
    UsuarioRepository usuarioRepository = UsuarioRepositoryImpl(usuarioData);
    return UsuarioService(usuarioRepository);
  }

  static CasaService createCasaService() {
    DioClient dioClient = DioClient();
    CasaData casaData = CasaData(dioClient);
    CasaRepository casaRepository = CasaRepositoryImpl(casaData);
    return CasaService(casaRepository);
  }



}
