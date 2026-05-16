import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/app/services/casa_service.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/presentation/screen/casas/crear_casa_screen.dart';

class ProviderCasas extends ChangeNotifier {
  CasaService casaService;
  ProviderCasas(this.casaService);

  bool isLoading = true;
  bool filtroActivoCasas = false;
  bool casasHomeLoading = false;

  String? error;
  List<Casa> casas = [];
  List<Casa> casasHome1 = [];
  List<Casa> casasHome2 = [];

  void _cargarCasas(List data) {
    for (var casa in data) {
      casas.add(casa);
    }
  }

  void _cargarCasasHome(List casas1, List casas2) {
    for (Casa casa in casas1) {
      casasHome1.add(casa);
    }
    for (Casa casa in casas2) {
      casasHome2.add(casa);
    }
  }

  Future<void> iniciarCasasHome() async {
    casasHomeLoading = true;
    final casas1 = await casaService.obtenerCasas(
      filtro: '',
      filtroActivo: true,
      limit: 3,
      tipoFiltro: 'populares',
    );
    final casas2 = await casaService.obtenerCasas(
      filtro: '',
      filtroActivo: true,
      limit: 3,
      tipoFiltro: 'recientes',
    );
    casasHome1 = casas1;

    casasHome2 = casas2;
    casasHomeLoading = false;
    notifyListeners();
  }

  Future<void> eliminarFiltro() async {
    isLoading = false;
    filtroActivoCasas = false;
    notifyListeners();
  }

  Future<void> obtenerCasas({
    String? filtro,
    String? tipoFiltro,
    bool? filtroActivo,
    int? limit,
  }) async {
    isLoading = true;
    casas.clear();
    try {
      if (filtro != null) {
        if (filtro == '+4') {
          filtro = '4';
        }
        filtroActivoCasas = true;
      }
      final List casasDB = await casaService.obtenerCasas(
        filtroActivo: filtroActivo,
        limit: limit,
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
