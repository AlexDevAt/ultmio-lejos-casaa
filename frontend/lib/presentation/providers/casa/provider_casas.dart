import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/app/services/casa_service.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/presentation/screen/casas/crear_casa_screen.dart';

class ProviderCasas extends ChangeNotifier {
  CasaService casaService;
  ProviderCasas(this.casaService);

  bool isLoading = false;
  bool casasCargadosPrimera = false;
  bool filtroActivo = false;

  String? error;
  List<Casa> casas = [];

  void _cargarCasas(List data) {
    for (var casa in data) {
      casas.add(casa);
    }
  }

  Future<void> eliminarFiltro() async {
    casasCargadosPrimera = false;
    notifyListeners();
  }

  Future<void> obtenerCasas({String? filtro,String? tipoFiltro}) async {
    casas.clear();
    try {
      if (filtro != null) {
        filtroActivo = true;
      }

      isLoading = true;
      final List casasDB = await casaService.obtenerCasas(filtro: filtro,tipoFiltro: tipoFiltro);
      _cargarCasas(casasDB);
      casasCargadosPrimera = true;
      notifyListeners();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
   Future<void> crearCasa(Casa casa) async {
    final Casa casaNew = await casaService.crearCasas(casa);
    casas.add(casaNew);
    notifyListeners();
  }


}
