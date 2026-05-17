import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/infrastructure/models/notificacion/notificacion_model.dart';

import 'package:lejos_de_casa_front/main.dart';
import 'package:lejos_de_casa_front/presentation/providers/notificacion/provider_notificacion.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ProviderWebSocket extends ChangeNotifier {
  ProviderNotificacion? providerNotificacion;
  WebSocketChannel? channel;
  bool isConnect = false;

  void actualizarProviderNotificacion(ProviderNotificacion providerNoti) {
    providerNotificacion = providerNoti;
  }

  Future<void> conectar(String curp) async {
    String urlWebSocket = 'ws://127.0.0.1:8000/ws/notificacion/$curp';

    try {
      channel = WebSocketChannel.connect(Uri.parse(urlWebSocket));

      channel!.stream.listen((event) {
        mensajeRecibido(event);
        notifyListeners();
      });
    } catch (e) {
      print('OCURRIO UN ERROR EN LA CONEXION DEL WEB SOCKET $e');
      GlobalContext.messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            'ERROR',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void mensajeRecibido(String event) {
    Map<String, dynamic> eventoToJson = jsonDecode(event);
    final res = Empty.fromJson(eventoToJson);
    providerNotificacion!.agregarNotificacion(res.data.toEntity());

    GlobalContext.messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          res.data.mensaje,
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: Colors.green.shade200,
      ),
    );
  }

  // void enviarNotificacion(data) {
  //   channel!.sink.add(data);
  // }
}

// To parse this JSON data, do
//
//     final empty = emptyFromJson(jsonString);

class Empty {
  String event;
  NotificacionModel data;

  Empty({required this.event, required this.data});

  factory Empty.fromJson(Map<String, dynamic> json) => Empty(
    event: json["event"],
    data: NotificacionModel.fromJson(json["data"]),
  );

  // Map<String, dynamic> toJson() => {"event": event, "data": Notificacino.toJson()};
}

class Data {
  int idNotificacion;
  String idDestinatario;
  String idEmisor;
  String tipo;
  DateTime fechaEnvio;
  bool leido;
  String mensaje;
  String nombreEmisor;
  String apellidosEmisor;

  Data({
    required this.idNotificacion,
    required this.idDestinatario,
    required this.idEmisor,
    required this.tipo,
    required this.fechaEnvio,
    required this.leido,
    required this.mensaje,
    required this.nombreEmisor,
    required this.apellidosEmisor,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idNotificacion: json["id_notificacion"],
    idDestinatario: json["id_destinatario"],
    idEmisor: json["id_emisor"],
    tipo: json["tipo"],
    fechaEnvio: DateTime.parse(json["fecha_envio"]),
    leido: json["leido"],
    mensaje: json["mensaje"],
    nombreEmisor: json["nombre_emisor"],
    apellidosEmisor: json["apellidos_emisor"],
  );

  Map<String, dynamic> toJson() => {
    "id_notificacion": idNotificacion,
    "id_destinatario": idDestinatario,
    "id_emisor": idEmisor,
    "tipo": tipo,
    "fecha_envio": fechaEnvio.toIso8601String(),
    "leido": leido,
    "mensaje": mensaje,
    "nombre_emisor": nombreEmisor,
    "apellidos_emisor": apellidosEmisor,
  };
}
