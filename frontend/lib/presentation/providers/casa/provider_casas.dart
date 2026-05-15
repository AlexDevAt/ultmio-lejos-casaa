import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/app/services/casa_service.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/presentation/screen/casas/crear_casa_screen.dart';

class ProviderCasas extends ChangeNotifier {
  CasaService casaService;
  ProviderCasas(this.casaService);

  bool isLoading = true;
  bool filtroActivo = false;

  String? error;
  List<Casa> casas = [];

  void _cargarCasas(List data) {
    for (var casa in data) {
      casas.add(casa);
    }
  }

  Future<void> eliminarFiltro() async {
    isLoading = false;
    notifyListeners();
  }

  Future<void> obtenerCasas({String? filtro, String? tipoFiltro}) async {
    isLoading = true;
    casas.clear();
    try {
      if (filtro != null) {
        if (filtro == '+4') {
          filtro = '4';
        }
        filtroActivo = true;
      }
      final List casasDB = await casaService.obtenerCasas(
        filtro: filtro,
        tipoFiltro: tipoFiltro,
      );
      _cargarCasas(casasDB);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> crearCasa(Casa casa) async {
    final Casa casaNew = await casaService.crearCasas(casa);
    casas.add(casaNew);
    notifyListeners();
  }
}
