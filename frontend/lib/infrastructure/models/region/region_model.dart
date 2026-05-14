import 'package:lejos_de_casa_front/domain/entities/region.dart';

class RegionModel {
  final int codigoPos;
  final String estado;
  final String municipio;

  RegionModel({
    required this.codigoPos,
    required this.estado,
    required this.municipio,
  });

  factory RegionModel.toJson(Map<String, dynamic> json) => RegionModel(
    codigoPos: int.tryParse(json['codigo_postal']) ?? 0,
    estado: json['estado'] ?? 'estado no encontrado',
    municipio: json['municipio']??'Municipio no ecnontrado',
  );

  Region toEntity() =>
      Region(codigoPos: codigoPos, estado: estado, municipio: municipio);
}
