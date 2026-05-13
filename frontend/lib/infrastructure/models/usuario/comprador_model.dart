import 'package:lejos_de_casa_front/domain/entities/comprador.dart';
import 'package:lejos_de_casa_front/domain/entities/propietario.dart';

class CompradorModel {
  String nombres;
  String apellidos;
  String? curp;
  DateTime? fechaRegistro;

  CompradorModel({
    required this.nombres,
    required this.curp,
    required this.apellidos,
    required this.fechaRegistro,
  });

  factory CompradorModel.fromEntity(Comprador entity) {
    return CompradorModel(
      nombres: entity.nombres,
      apellidos: entity.apellidos,
      fechaRegistro: entity.fechaRegistro!,
      curp: entity.curp,
    );
  }

  factory CompradorModel.fromJson(Map<String, dynamic> json) => CompradorModel(
    nombres: json["nombres"],
    curp: json['curp'],
    apellidos: json["apellidos"],
    fechaRegistro: json["fecha_registro"] != null
    ? DateTime.parse(json["fecha_registro"])
    : null,
  );

  Map<String, dynamic> toJson() => {
    "nombres": nombres,
    "apellidos": apellidos,
    "fecha_registro": fechaRegistro!.toIso8601String(),
  };

  Comprador toEntity() => Comprador(
    nombres: nombres,
    curp: curp!,
    apellidos: apellidos,
    fechaRegistro: fechaRegistro,
  );
}
