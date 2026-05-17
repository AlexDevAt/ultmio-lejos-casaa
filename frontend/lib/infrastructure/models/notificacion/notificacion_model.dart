import 'package:lejos_de_casa_front/domain/entities/notificacion.dart';

class NotificacionModel {
  int idNotificacion;
  String? idDestinatario;
  String idEmisor;
  String tipo;
  DateTime fechaEnvio;
  bool leido;
  String mensaje;
  String nombreEmisor;
  String apellidosEmisor;

  NotificacionModel({
    required this.idNotificacion,
    this.idDestinatario,
    required this.idEmisor,
    required this.tipo,
    required this.fechaEnvio,
    required this.leido,
    required this.mensaje,
    required this.nombreEmisor,
    required this.apellidosEmisor,
  });

  factory NotificacionModel.fromJson(Map<String, dynamic> json) =>
      NotificacionModel(
        idNotificacion: json['id_notificacion'],
        idEmisor: json['id_emisor'],
        idDestinatario: json['id_destinatario'],
        tipo: json['tipo'],
        fechaEnvio: DateTime.parse(json['fecha_envio']) ,
        leido: json['leido'],
        mensaje: json['mensaje'],
        nombreEmisor: json['nombre_emisor'],
        apellidosEmisor: json['apellidos_emisor'],
      );

  NotificacionEnty toEntity() => NotificacionEnty(
    idNotificacion: idNotificacion,
    nombreEmisor: nombreEmisor,
    apellidosEmisor: apellidosEmisor,
    idEmisor: idEmisor,
    tipo: tipo,
    fechaEnvio: fechaEnvio,
    leido: leido,
    mensaje: mensaje,
  );
}
