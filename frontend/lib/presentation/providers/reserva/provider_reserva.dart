import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/app/services/reservas_service.dart';
import 'package:lejos_de_casa_front/domain/entities/reserva.dart';

class ProviderReserva extends ChangeNotifier {
  ReservasService reservasService;
  ProviderReserva(this.reservasService);

  bool isLoading = false;
  String? error;
  List<Reserva> reservas = [];

  Future<void> obtenerReservasUsuario(String curp) async {
    try {
      isLoading = true;
      final List reservasDB = await reservasService.obtenerReservasUsuario(
        curp,
      );
      limpiarReservas();
      _cargarReservas(reservasDB);
      notifyListeners();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _cargarReservas(List reservasData) {
    for (var reserva in reservasData) {
      reservas.add(reserva);
    }
  }

  void limpiarReservas() {
    reservas.clear();
    notifyListeners();
  }
}
