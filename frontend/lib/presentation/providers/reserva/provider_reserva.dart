import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/app/services/reservas_service.dart';
import 'package:lejos_de_casa_front/domain/entities/reserva.dart';

class ProviderReserva extends ChangeNotifier {
  ReservasService reservasService;
  ProviderReserva(this.reservasService);

  bool isLoading = true;
  bool creadonReserva = false;
  bool boolReservaCreada = false;
  String? estadoReserva = '';
  String? error;
  List<Reserva> reservas = [];

  void inicializarReservas(List<Reserva> reservasU) {
    reservas = reservasU;
  }

  bool reservaExiste(int idCasa) {
    return reservas.any((element) => element.idCasa == idCasa);
  }

  Future<void> reservarCasa(int idCasa, String idComprador) async {
    error = null;
    creadonReserva = true;
    notifyListeners();
    try {
      final Reserva reserva = await reservasService.crearReserva(
        idCasa,
        idComprador,
      );
      boolReservaCreada = true;
      reservas.add(reserva);
    } catch (e) {
      error = e.toString();
    } finally {
      await Future.delayed(Duration(seconds: 3));
      creadonReserva = false;
      notifyListeners();
    }
  }

  Future<void> obtenerReservasUsuario(String curp) async {
    isLoading = true;
    try {
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
      await Future.delayed(Duration(seconds: 2));
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
