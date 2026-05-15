import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/app/services/resenia_service.dart';
import 'package:lejos_de_casa_front/domain/entities/resenia.dart';

class ProviderResenia extends ChangeNotifier {
  final ReseniaService service;
  ProviderResenia(this.service);

  final List<Resenia> reseniasActualesCasa = [];
  final List<Resenia> reseniasActualesUsuarios = [];
  bool isLoading = true;
  String? error;
  Future<void> obtenerReseniasCasa(dynamic id) async {
    try {
      final List resenias = await service.obtenerResenias(id);

      limpiarReseniasTipo('casa');
      _cargarReenias(resenias, 'casa');
      notifyListeners();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> obtenerReseniasUsuario(dynamic id) async {
    try {
      final List resenias = await service.obtenerResenias(id);
      limpiarReseniasTipo('user');
      _cargarReenias(resenias, 'user');
      notifyListeners();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  void _cargarReenias(List resenias, String tipo) {
    for (Resenia resenia in resenias) {
      tipo == 'casa'
          ? reseniasActualesCasa.add(resenia)
          : reseniasActualesUsuarios.add(resenia);
    }
  }

  void limpiarTodasResenias() {
    isLoading = true;
    reseniasActualesCasa.clear();
    reseniasActualesUsuarios.clear();
    notifyListeners();
  }

  void limpiarReseniasTipo(String tipo) {
    isLoading = true;
    tipo == 'casa'
        ? reseniasActualesCasa.clear()
        : reseniasActualesUsuarios.clear();
    notifyListeners();
  }
}
