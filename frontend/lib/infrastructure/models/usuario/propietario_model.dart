import 'package:lejos_de_casa_front/domain/entities/propietario.dart';

class PropietarioModel {
  String nombres;
  String apellidos;
  String curp;
  DateTime fechaRegistro;

  PropietarioModel({
    required this.nombres,
    required this.curp,
    required this.apellidos,
    required this.fechaRegistro,
  });

  factory PropietarioModel.fromEntity(Propietario entity) {
    return PropietarioModel(
      nombres: entity.nombres,
      apellidos: entity.apellidos,
      fechaRegistro: entity.fechaRegistro,
      curp: entity.curp
    );
  }

  factory PropietarioModel.fromJson(Map<String, dynamic> json) =>
      PropietarioModel(
        nombres: json["nombres"],
        curp: json['curp'],
        apellidos: json["apellidos"],
        fechaRegistro: DateTime.parse(json["fecha_registro"]),
      );

  Map<String, dynamic> toJson() => {
    "nombres": nombres,
    "apellidos": apellidos,
    "fecha_registro": fechaRegistro.toIso8601String(),
  };

  Propietario toEntity() => Propietario(
    curp: curp,
    nombres: nombres,
    apellidos: apellidos,
    fechaRegistro: fechaRegistro,
  );
}
