import 'package:lejos_de_casa_front/domain/entities/casa.dart';

abstract class CasaRepository {
  Future<Casa> obtenerCasa(int id);
  Future<List<Casa>> obtenerCasas({String? filtro,String? tipoFiltro});
  Future<Casa> actualizarCasa(int id, Map<String, dynamic> data);
  Future<void> borrarCasa(int id);
  Future<Casa> crearCasa(Casa casa);
}
