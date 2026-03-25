import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/domain/repositories/casa_repository.dart';

class CasaService {
  CasaRepository repo;
  CasaService(this.repo);

  Future<List<Casa>> obtenerCasas({String? filtro, String? tipoFiltro}) async {
    final casas = await repo.obtenerCasas(
      filtro: filtro,
      tipoFiltro: tipoFiltro,
    );
    if (casas.isNotEmpty) return casas;
    throw Exception('No se encontraron casas');
  }

  Future<Casa> crearCasas(Casa casa) async {
    return await repo.crearCasa(casa);
  }
}
