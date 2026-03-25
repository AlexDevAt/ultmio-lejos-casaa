import 'package:lejos_de_casa_front/domain/entities/usuario.dart';
import 'package:lejos_de_casa_front/domain/repositories/usuario_repository.dart';
import 'package:lejos_de_casa_front/infrastructure/data/usuario_data.dart';
import 'package:lejos_de_casa_front/infrastructure/models/usuario/usuario_model.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  UsuarioData dataSource;
  UsuarioRepositoryImpl(this.dataSource);
  @override
  Future<Usuario> obtenerUsuario(String curp) async {
    final model = await dataSource.obtenerUsuario(curp);
    return model.toEntity();
  }

  @override
  Future<List<Usuario>> obtenerUsuarios() async {
    final model = await dataSource.obtenerUsuarios();
    return model.map((user) => user.toEntity()).toList();
  }

  @override
  Future<Usuario> crearUsuario(Usuario usuario) async {
    final model = UsuarioModel(
      curp: usuario.curp,
      nombres: usuario.nombres,
      apellidos: usuario.apellidos,
      correo: usuario.correo,
      telefono: usuario.telefono,
      rol: usuario.rol,
      fechaRegistro: usuario.fechaRegistro,
      calle: usuario.calle,
      numeroInterior: usuario.numeroInterior,
      codigoPostal: usuario.codigoPostal,
      municipio: usuario.municipio,
      ciudad: usuario.ciudad,
      contrasenia: usuario.contrasenia
    );
    final res = await dataSource.crearUsuario(model.toJson());
    return model.toEntity();
  }

  @override
  Future<Usuario> actualizarUsuario(
    String curp,
    Map<String, dynamic> data,
  ) async {
    final model = await dataSource.actualizarUsuario(curp, data);
    return model.toEntity();
  }

  @override
  Future<void> borrarUsuario(String curp) async {
    await dataSource.borrarUsuario(curp);
  }
}
