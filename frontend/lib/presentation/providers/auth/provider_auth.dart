import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/app/services/auth_service.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';

class ProviderAuth extends ChangeNotifier {
  String? token;
  bool logueado = false;
  AuthService authService;
  ProviderAuth(this.authService);

  Future<void> login(
    String correo,
    String password,
    ProviderUsuarios usuariosProvider,
  ) async {
    token = await authService.login(correo.trim(), password);
    logueado = true;
    usuariosProvider.cargarUsuarioActual(token!);
    notifyListeners();
  }
}
