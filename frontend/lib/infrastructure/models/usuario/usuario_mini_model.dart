
import 'package:lejos_de_casa_front/domain/entities/usuario_mini.dart';

class UsuarioMiniModel {
  final String nombres;
  final String apellidos;

  UsuarioMiniModel({required this.nombres, required this.apellidos});

  factory UsuarioMiniModel.fromJson(Map<String, dynamic> json) =>
      UsuarioMiniModel(
        nombres: json['nombres'] ?? 'nombre not found',
        apellidos: json['apellidos'] ?? 'apellidos not found',
      );

  UsuarioMini toEntity() => UsuarioMini(nombre: nombres, apellidos: apellidos);
}
