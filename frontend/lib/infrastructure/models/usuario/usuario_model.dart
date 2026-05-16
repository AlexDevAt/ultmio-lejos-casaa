
import 'package:lejos_de_casa_front/domain/entities/usuario.dart';
import 'package:lejos_de_casa_front/infrastructure/models/casa/casa_model.dart';
import 'package:lejos_de_casa_front/infrastructure/models/reserva/reserva_model.dart';

class UsuarioModel {
  final String curp;
  final String nombres;
  final String apellidos;
  final String correo;
  final String telefono;
  final String contrasenia;
  final Roles rol;
  final DateTime fechaRegistro;
  final String calle;
  final int numeroInterior;
  final String codigoPostal;
  final String municipio;
  final String ciudad;
  final double? calificacionPromedio;
  final int? totalResenias;
  final List<CasaModel>? casasVenta;
  final List<ReservaModel>? reservas;

  UsuarioModel({
    this.calificacionPromedio,
    this.totalResenias,
    this.casasVenta,
    this.reservas,
    required this.curp,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.telefono,
    required this.contrasenia,
    required this.rol,
    required this.fechaRegistro,
    required this.calle,
    required this.numeroInterior,
    required this.codigoPostal,
    required this.municipio,
    required this.ciudad,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
    curp: json['curp'] ?? '',
    nombres: json['nombres'] ?? '',
    apellidos: json['apellidos'] ?? '',
    correo: json['correo'] ?? '',
    telefono: json['telefono'] ?? '',
    contrasenia: json['contrasenia'] ?? '',
    rol: fromStringToRol(json['rol'] as String),
    fechaRegistro: DateTime.parse(json['fecha_registro'] as String),
    calle: json['calle'] ?? '',
    numeroInterior: (json['num_interior'] as num).toInt(),
    codigoPostal: json['codigo_postal'] ?? '',
    municipio: json['municipio'] ?? '',
    ciudad: json['ciudad'] ?? '',
    calificacionPromedio: json['calificacion_promedio'] ?? 0,
    totalResenias: json['totalResenias'] ?? 0,
    reservas: json['reservas'] != null ? (json['reservas'] as List).map((reserva) =>  ReservaModel.fromJson(reserva)).toList() : null,
    casasVenta:json['casas'] != null ?( json['casas'] as List).map((reserva) =>  CasaModel.fromJson(reserva)).toList() : null

  );

  Map<String, dynamic> toJson() {
    return {
      "curp": curp,
      "nombres": nombres,
      "apellidos": apellidos,
      "correo": correo,
      "telefono": telefono,
      "contrasenia": contrasenia,
      "rol": rolToString(rol),
      "fecha_registro": fechaRegistro.toIso8601String(),
      "calle": calle,
      "num_interior": numeroInterior,
      "codigo_postal": codigoPostal,
      "municipio": municipio,
      "ciudad": ciudad,
    };
  }

  Usuario toEntity() => Usuario(
    curp: curp,
    nombres: nombres,
    apellidos: apellidos,
    correo: correo,
    telefono: telefono,
    contrasenia: contrasenia,
    rol: rol,
    fechaRegistro: fechaRegistro,
    calle: calle,
    numeroInterior: numeroInterior,
    codigoPostal: codigoPostal,
    municipio: municipio,
    ciudad: ciudad,
    calificacionPromedio: calificacionPromedio,
    casasVenta: casasVenta?.map((e) => e.toEntity(),).toList(),
    reservas: reservas?.map((e) => e.toEntity(),).toList()
  );
}



String rolToString(Roles rol) {
  switch (rol) {
    case Roles.vendedor:
      return 'vendedor';
    case Roles.comprador:
      return 'comprador';
    case Roles.ambos:
      return 'ambos';
  }
}

Roles fromStringToRol(String rol) {
  switch (rol) {
    case 'vendedor':
      return Roles.vendedor;
    case 'comprador':
      return Roles.comprador;
    case 'ambos':
      return Roles.ambos;
    default:
      throw Exception("Rol invalido $rol");
  }
}
