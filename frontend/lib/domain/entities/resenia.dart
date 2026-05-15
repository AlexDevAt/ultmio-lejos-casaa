
import 'package:lejos_de_casa_front/domain/entities/usuario_mini.dart';

class Resenia {
  final int calificacion;
  final String comentario;
  final DateTime fecha;
  final UsuarioMini calificador;

  Resenia({required this.calificacion, required this.comentario, required this.fecha, required this.calificador});
}
