import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/domain/entities/usuario.dart';
import 'package:lejos_de_casa_front/domain/repositories/casa_repository.dart';
import 'package:lejos_de_casa_front/infrastructure/data/casa_data.dart';
import 'package:lejos_de_casa_front/infrastructure/models/casa/casa_model.dart';
import 'package:lejos_de_casa_front/infrastructure/models/region/region_model.dart';
import 'package:lejos_de_casa_front/infrastructure/models/usuario/propietario_model.dart';

class CasaRepositoryImpl implements CasaRepository {
  CasaData dataSource;
  CasaRepositoryImpl(this.dataSource);

  @override
  Future<Casa> actualizarCasa(int id, Map<String, dynamic> data) {
    // TODO: implement actualizarCasa
    throw UnimplementedError();
  }

  @override
  Future<void> borrarCasa(int id) {
    // TODO: implement borrarCasa
    throw UnimplementedError();
  }

  @override
  Future<Casa> crearCasa(Casa casa) async {

    final model = CasaModel(
      id: casa.id,
      cupo: casa.cupo,
      tipo: casa.tipo,
      imagen: casa.imagen,
      cuartos: casa.cuartos,
      calle: casa.calle,
      numInterior: casa.numInterior,
      precio: casa.precio,
      idRegion: casa.idRegion,
      idPropietario: casa.idPropietario,
      titulo: casa.titulo,
    );

    final res = await dataSource.crearCasa(model.toJson());
    return res.toEntity();
  }

  @override
  Future<Casa> obtenerCasa(int id) {
    // TODO: implement obtenerCasa
    throw UnimplementedError();
  }

  @override
  Future<List<Casa>> obtenerCasas({String? filtro,
    String? tipoFiltro,
    bool? filtroActivo,
    int? limit,}) async {
    final model = await dataSource.obtenerCasas(
      filtroActivo: filtroActivo,
      limit: limit,
      filtro: filtro,
      tipoFiltro: tipoFiltro,
    );
    return model.map((casa) => casa.toEntity()).toList();
  }
}
