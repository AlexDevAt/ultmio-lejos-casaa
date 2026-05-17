class NotificacionEnty {
  final int idNotificacion;
  final String? idDestinatario;
  final String idEmisor;
  final String tipo;
  final DateTime fechaEnvio;
  final bool leido;
  final String mensaje;
  final String nombreEmisor;
  final String apellidosEmisor;

  NotificacionEnty({
    required this.idNotificacion,
    this.idDestinatario,
    required this.nombreEmisor,
    required this.apellidosEmisor,
    required this.idEmisor,
    required this.tipo,
    required this.fechaEnvio,
    required this.leido,
    required this.mensaje,
  });
}
