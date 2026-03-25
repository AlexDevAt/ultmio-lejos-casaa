import 'package:lejos_de_casa_front/domain/entities/usuario.dart';

abstract class UsuarioRepository {
  Future<Usuario> obtenerUsuario(String curp);
  Future<List<Usuario>> obtenerUsuarios();
  Future<Usuario> actualizarUsuario(String curp, Map<String, dynamic> data);
  Future<void> borrarUsuario(String curp);
  Future<Usuario> crearUsuario(Usuario usuario);
}
