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
    required this.region,
    required this.propietario, required this.titulo,
  });

  factory CasaModel.fromJson(Map<String, dynamic> json) => CasaModel(
    id: json["id"] == null ? 0 : int.parse(json["id"].toString()),
    titulo:json['titulo'],
    cupo: json["cupo"],
    tipo: json["tipo"],
    imagen: json["imagen"],
    cuartos: json["cuartos"],
    calle: json["calle"],
    numInterior: json["num_interior"],
    precio: (json["precio"] as num).toDouble(),
    region: json['region'] != null 
    ? RegionModel.toJson(json['region'])
    :null,
   propietario: json["propietario"] != null
    ? PropietarioModel.fromJson(json["propietario"])
    : null
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "titulo":titulo,
    "cupo": cupo,
    "tipo": tipo,
    "imagen": imagen,
    "cuartos": cuartos,
    "calle": calle,
    "num_interior": numInterior,
    "precio": precio,
    "idRegion": '',
    "propietario": propietario!.toJson(),
    'id_propietario': propietario!.curp
  };

  Casa toEntity() => Casa(
    id: id,
    titulo: titulo,
    cupo: cupo,
    tipo: tipoCasaFromString(tipo),
    imagen: imagen,
    cuartos: cuartos,
    calle: calle,
    numInterior: numInterior,
    precio: precio,
    region: region!.toEntity(),
    propietario: propietario!.toEntity(),
  );
}

 TipoCasa tipoCasaFromString(String tipo) {
  switch (tipo.toLowerCase()) {
    case 'unaplanta':
    case 'una_planta':
    case 'Una planta':
      return TipoCasa.unaPlanta;
    case 'dosplantas':
    case 'dos_plantas':
    case 'dos plantas':
      return TipoCasa.dosPlantas;
    default:
      return TipoCasa.otroTipo;
  }
}

String tipoCasaToString(TipoCasa tipo) {
  switch (tipo) {
    case TipoCasa.unaPlanta:
      return 'unaPlanta';
    case TipoCasa.dosPlantas:
      return 'dosPlantas';
    case TipoCasa.otroTipo:
      return 'otroTipo';
  }
}

String tipoCasaToApi(TipoCasa tipo) {
  switch (tipo) {
    case TipoCasa.unaPlanta:
      return 'Una planta';
    case TipoCasa.dosPlantas:
      return 'Dos plantas';
    case TipoCasa.otroTipo:
      return 'Otro tipo';
  }
}
