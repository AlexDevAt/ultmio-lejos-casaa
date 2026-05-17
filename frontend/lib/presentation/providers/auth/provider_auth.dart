import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/app/services/auth_service.dart';
import 'package:lejos_de_casa_front/presentation/providers/casa/provider_casas.dart';
import 'package:lejos_de_casa_front/presentation/providers/notificacion/provider_notificacion.dart';
import 'package:lejos_de_casa_front/presentation/providers/reserva/provider_reserva.dart';
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
    ProviderReserva providerReserva,
    ProviderCasas providerCasa,
    ProviderNotificacion providerNotificacion
  ) async {
    token = await authService.login(correo.trim(), password);
    logueado = true;
    await usuariosProvider.cargarUsuarioActual(token!);
    providerReserva.inicializarReservas(
      usuariosProvider.usuarioActual!.reservas!,
    );
    await providerCasa.iniciarCasasHome();
    await providerNotificacion.obtenerNotificaciones();

    notifyListeners();
  }
}
