import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/app/services/notificacion_service.dart';
import 'package:lejos_de_casa_front/domain/entities/notificacion.dart';
import 'package:lejos_de_casa_front/domain/repositories/notificacion_repository.dart';

class ProviderNotificacion extends ChangeNotifier {
  final NotificacionService service;
  ProviderNotificacion(this.service);

  bool isLoading = false;
  List<NotificacionEnty> notificacionesActuales = [];

  Future<void> obtenerNotificaciones(String curp) async {
    try {
      isLoading = true;
      final notificaciones = await service.obtenerNotificaciones(curp);
      _agregarNotificaciones(notificaciones);
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _agregarNotificaciones(List notis) {
    for (NotificacionEnty noti in notis) {
      notificacionesActuales.add(noti);
    }
  }
}
