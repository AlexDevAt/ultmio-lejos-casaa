import 'package:lejos_de_casa_front/domain/entities/resenia.dart';
import 'package:lejos_de_casa_front/infrastructure/models/usuario/usuario_mini_model.dart';

class ReseniaModel {
  final int calificacion;
  final String comentario;
  final DateTime fecha;
  final UsuarioMiniModel calificador;

  ReseniaModel({
    required this.calificacion,
    required this.comentario,
    required this.fecha,
    required this.calificador,
  });

  factory ReseniaModel.fromJson(Map<String, dynamic> json) => ReseniaModel(
    calificacion: json['calificacion'],
    comentario: json['comentario'],
    fecha: DateTime.parse(json['fecha']),
    calificador: UsuarioMiniModel.fromJson(json['calificador']),
  );

  Resenia toEntity() => Resenia(
    calificacion: calificacion,
    comentario: comentario,
    fecha: fecha,
    calificador: calificador.toEntity(),
  );
}
