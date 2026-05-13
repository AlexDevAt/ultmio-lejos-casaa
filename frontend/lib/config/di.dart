import 'package:lejos_de_casa_front/app/services/auth_service.dart';
import 'package:lejos_de_casa_front/app/services/casa_service.dart';
import 'package:lejos_de_casa_front/app/services/reservas_service.dart';
import 'package:lejos_de_casa_front/app/services/usuario_service.dart';
import 'package:lejos_de_casa_front/config/dio_cliente.dart';
import 'package:lejos_de_casa_front/domain/repositories/casa_repository.dart';
import 'package:lejos_de_casa_front/domain/repositories/reservas_repository.dart';
import 'package:lejos_de_casa_front/domain/repositories/usuario_repository.dart';
import 'package:lejos_de_casa_front/infrastructure/data/auth_data.dart';
import 'package:lejos_de_casa_front/infrastructure/data/casa_data.dart';
import 'package:lejos_de_casa_front/infrastructure/data/reservas_data.dart';
import 'package:lejos_de_casa_front/infrastructure/data/usuario_data.dart';
import 'package:lejos_de_casa_front/infrastructure/repositories/auth/auth_repository_impl.dart';
import 'package:lejos_de_casa_front/infrastructure/repositories/casa/casa_repository_impl.dart';
import 'package:lejos_de_casa_front/infrastructure/repositories/reservas/reservas_repository_impl.dart';
import 'package:lejos_de_casa_front/infrastructure/repositories/usuario/usuario_repository_impl.dart';

class Di {
  static UsuarioService createUsuarioService() {
    DioClient dioClient = DioClient();
    UsuarioData usuarioData = UsuarioData(dioClient);
    UsuarioRepository usuarioRepository = UsuarioRepositoryImpl(usuarioData);
    return UsuarioService(usuarioRepository);
  }

  static ReservasService createReservaService() {
    DioClient dioClient = DioClient();
    ReservasData reservasData = ReservasData(dioClient);
    ReservasRepository reservasRepository = ReservasRepositoryImpl(
      reservasData,
    );
    return ReservasService(reservasRepository);
  }

  static AuthService createAuthService() {
    DioClient dioClient = DioClient();
    AuthData authData = AuthData(dioClient);
    AuthRepositoryImpl authRepository = AuthRepositoryImpl(authData);
    return AuthService(authRepository);
  }

  static CasaService createCasaService() {
    DioClient dioClient = DioClient();
    CasaData casaData = CasaData(dioClient);
    CasaRepository casaRepository = CasaRepositoryImpl(casaData);
    return CasaService(casaRepository);
  }
}
