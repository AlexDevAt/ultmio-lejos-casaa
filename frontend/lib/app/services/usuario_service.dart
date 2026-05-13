import 'package:lejos_de_casa_front/domain/entities/usuario.dart';
import 'package:lejos_de_casa_front/domain/repositories/usuario_repository.dart';

class UsuarioService {
  final UsuarioRepository repo;
  UsuarioService(this.repo);

  Future<Usuario> obtenerUsuario(String curp) async {
    if (curp.isEmpty) throw Exception('Curp invalida');
    return await repo.obtenerUsuario(curp);
  }

  Future<Usuario> obtenerUsuarioActual(String token) async {
    return await repo.obtenerUsuarioActual(token);
  }




  Future<List<Usuario>> obtenerUsuarios() async {
    final users = await repo.obtenerUsuarios();
    if (users.isNotEmpty) return users;
    throw Exception('No se encontraron usuarios');
  }

  Future<Usuario> crearUsuario(Usuario usuario) async {
    return await repo.crearUsuario(usuario);

  }

  Future<Usuario> actualizarUsuario(
    String curp,
    Map<String, dynamic> data,
  ) async {
    if (curp.isEmpty) throw Exception('Curp invalida');
    if (data.isEmpty) throw Exception('No hay cambios');
    return repo.actualizarUsuario(curp, data);
  }

  Future<void> borrarUsuario(String curp) async {
    if (curp.isEmpty) throw Exception('Curp invalida');
    await repo.borrarUsuario(curp);
  }
}
