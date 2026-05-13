import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/domain/entities/comprador.dart';

class Reserva {
  final int id;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String estado;
  final Casa casa;
  final Comprador comprador;

  Reserva({required this.id, required this.fechaInicio, required this.fechaFin, required this.estado, required this.casa, required this.comprador});
}
