import 'package:lejos_de_casa_front/domain/entities/reserva.dart';
import 'package:lejos_de_casa_front/infrastructure/models/casa/casa_model.dart';
import 'package:lejos_de_casa_front/infrastructure/models/usuario/comprador_model.dart';

class ReservaModel {
  int id;
  DateTime fechaInicio;
  DateTime fechaFin;
  String estado;
  final String idComprador;
  final int idCasa;
  CasaModel? casa;
  CompradorModel? comprador;
  ReservaModel({
    required this.id,
    required this.fechaInicio,
    required this.fechaFin,
    required this.estado,
    this.casa,
    this.comprador, required this.idComprador, required this.idCasa,
  });

  factory ReservaModel.fromJson(Map<String, dynamic> json,{String curpActual = '',int idCasaActual = -1}) => ReservaModel(
    id: json['id_reserva'] ,
    fechaInicio: DateTime.parse(json['fecha_inicio']),
    fechaFin: DateTime.parse(json['fecha_inicio']),
    estado: json['estado'],
    casa: json['casa'] != null
     ? CasaModel.fromJson(json['casa']) 
     : null,
    comprador: json['comprador'] != null
    ? CompradorModel.fromJson(json['comprador'])
    :null,
     idComprador: json['idComprador'], 
     idCasa: json['idCasa'] ,
  );

  Reserva toEntity() => Reserva(
  id: id,
  fechaInicio: fechaInicio,
  fechaFin: fechaFin,
  estado: estado,
  casa: casa?.toEntity(),
  comprador: comprador?.toEntity(), idCasa: idCasa, idComprador: idComprador,
);
}
