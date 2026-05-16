import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/domain/entities/resenia.dart';
import 'package:lejos_de_casa_front/domain/entities/reserva.dart';

enum Roles { vendedor, comprador, ambos }

class Usuario {
  final String curp;
  final String nombres;
  final String apellidos;
  final String correo;
  final String telefono;
  final Roles rol;
  final DateTime fechaRegistro;
  final String calle;
  final int numeroInterior;
  final String codigoPostal;
  final String municipio;
  final String ciudad;
  final String contrasenia;
  final double? calificacionPromedio;
  final int? totalResenias;
  final List<Casa>? casasVenta;
  final List<Reserva>? reservas;

  Usuario({
    this.calificacionPromedio,
    this.totalResenias,
    this.reservas,
    this.casasVenta,
    required this.curp,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.telefono,
    required this.rol,
    required this.fechaRegistro,
    required this.calle,
    required this.numeroInterior,
    required this.codigoPostal,
    required this.municipio,
    required this.ciudad,
    required this.contrasenia,
  });
}
