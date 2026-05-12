import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/app/services/usuario_service.dart';
import 'package:lejos_de_casa_front/domain/entities/usuario.dart';

class ProviderUsuarios extends ChangeNotifier {
  UsuarioService usuarioService;
  ProviderUsuarios(this.usuarioService);

  String token = '';
  bool isLoading = false;
  bool usuariosCargadosPrimera = false;

  String? error;
  List<Usuario> usuarios = [];

  // Future<void> login(String email, String password) {
    
  // }

  void _cargarUsuarios(List users) {
    for (var user in users) {
      usuarios.add(user);
    }
  }

  Future<void> crearUsuario(Usuario usuario) async {
    final Usuario user = await usuarioService.crearUsuario(usuario);
    usuarios.add(user);
    notifyListeners();
  }

  Future<void> borrarUsuario(String curp) async {
    await usuarioService.borrarUsuario(curp);
    final indice = usuarios.indexWhere((u) => u.curp == curp);
    usuarios.removeAt(indice);
    notifyListeners();
  }

  Future<void> actualizarUsuario(String curp, Map<String, dynamic> data) async {
    try {
      final Usuario usuarioUpdate = await usuarioService.actualizarUsuario(
        curp,
        data,
      );

      final indice = usuarios.indexWhere((u) => u.curp == curp);
      if (indice != -1) {
        // reemplaza el objeto viejo por el nuevo
        usuarios[indice] = usuarioUpdate;
      }
      notifyListeners();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> obtenerUsuarios() async {
    try {
      isLoading = true;
      final List usuariosDb = await usuarioService.obtenerUsuarios();
      _cargarUsuarios(usuariosDb);
      usuariosCargadosPrimera = true;
      notifyListeners();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
