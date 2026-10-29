import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/domain/entities/region.dart';
import 'package:lejos_de_casa_front/infrastructure/models/region/region_model.dart';
import 'package:lejos_de_casa_front/infrastructure/models/usuario/propietario_model.dart';

class CasaModel {
  final int id;
  final String titulo;
  final int cupo;
  final String tipo;
  final String imagen;
  final int cuartos;
  final String calle;
  final int numInterior;
  final double precio;
  final String idRegion;
  final String idPropietario;
  final RegionModel? region;
  final PropietarioModel? propietario;

  CasaModel({
    required this.id,
    required this.cupo,
    required this.tipo,
    required this.imagen,
    required this.cuartos,
    required this.calle,
    required this.numInterior,
    required this.precio,
     this.region,
     this.propietario,
    required this.titulo,
    required this.idRegion,
    required this.idPropietario,
  });

  factory CasaModel.fromJson(Map<String, dynamic> json) => CasaModel(
    id: json["id"] == null ? 0 : int.parse(json["id"].toString()),
    titulo: json['titulo'],
    cupo: json["cupo"],
    tipo: json["tipo"],
    imagen: json["imagen"],
    cuartos: json["cuartos"],
    calle: json["calle"],
    numInterior: json["num_interior"],
    precio: (json["precio"] as num).toDouble(),
    region: json['region'] != null ? RegionModel.toJson(json['region']) : null,
    propietario: json["propietario"] != null
        ? PropietarioModel.fromJson(json["propietario"])
        : null,
    idPropietario: json['id_propietario'],
    idRegion: json['idRegion'] ?? json['id_region'],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "titulo": titulo,
    "cupo": cupo,
    "tipo": tipo,
    "imagen": imagen,
    "cuartos": cuartos,
    "calle": calle,
    "num_interior": numInterior,
    "precio": precio,
    "idRegion": idRegion,
    'id_propietario': idPropietario,
  };

  Casa toEntity() => Casa(
    id: id,
    titulo: titulo,
    cupo: cupo,
    tipo: tipo,
    imagen: imagen,
    cuartos: cuartos,
    calle: calle,
    numInterior: numInterior,
    precio: precio,
    region: region?.toEntity(),
    propietario: propietario?.toEntity(),
    idRegion: idRegion,
    idPropietario: idPropietario,
  );

  static Map<String, dynamic> toJsonFromEntity(Casa casa) => {
    "id": casa.id,
    "titulo": casa.titulo,
    "cupo": casa.cupo,
    "tipo": casa.tipo,
    "imagen": casa.imagen,
    "cuartos": casa.cuartos,
    "calle": casa.calle,
    "num_interior": casa.numInterior,
    "precio": casa.precio,
    "idRegion": casa.idRegion,
    'id_propietario': casa.propietario!.curp,
  };
}
