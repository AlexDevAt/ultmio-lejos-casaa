import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/notificacion.dart';
import 'package:lejos_de_casa_front/helpers/formatos/format_date.dart';
import 'package:lejos_de_casa_front/presentation/providers/notificacion/provider_notificacion.dart';
import 'package:lejos_de_casa_front/presentation/widgets/card_filtro.dart';
import 'package:provider/provider.dart';

class NotificacionesScreen extends StatelessWidget {
  const NotificacionesScreen({super.key});
  static String name = 'notificaciones_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notificaciones',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 27),
            ),
            Text(
              'Mantente al tanto de todo lo que sucede',
              style: TextStyle(
                color: Color(0xFF49454F),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: _NotiView(),
      ),
    );
  }
}

class _NotiView extends StatelessWidget {
  const _NotiView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProviderNotificacion providerNotificacion = context
        .watch<ProviderNotificacion>();

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CardFiltro(
                textoSup: 'Todas',
                textoinF: '',
                paddingHorText: 5,
                heightDynamic: true,
              ),
              SizedBox(width: 4),
              CardFiltro(
                textoSup: 'Reservas',
                textoinF: '',
                paddingHorText: 5,
                heightDynamic: true,
              ),
              SizedBox(width: 4),
              CardFiltro(
                textoSup: 'Pagos',
                textoinF: '',
                paddingHorText: 5,
                heightDynamic: true,
              ),
              SizedBox(width: 4),
              CardFiltro(
                textoSup: 'Mensajes',
                textoinF: '',
                paddingHorText: 5,
                heightDynamic: true,
              ),
              SizedBox(width: 4),
              CardFiltro(
                textoSup: 'Promo',
                textoinF: '',
                paddingHorText: 5,
                heightDynamic: true,
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        Expanded(
          child: ListView.builder(
            itemCount: providerNotificacion.notificacionesActuales.length,
            itemBuilder: (context, index) {
              return CardNotificacion(notification: providerNotificacion.notificacionesActuales[index],);
            },
          ),
        ),
      ],
    );
  }
}

class CardNotificacion extends StatelessWidget {
  const CardNotificacion({super.key, required this.notification});
  final NotificacionEnty notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black45.withValues(),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // _EspacioIcon(),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'El usuario ${notification.nombreEmisor}',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  Text(
                    notification.mensaje,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Text(FormatDate.formatDiferenciaTiempo( notification.fechaEnvio), style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EspacioIcon extends StatelessWidget {
  const _EspacioIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: Icon(Icons.check, size: 50, color: Colors.greenAccent.shade700),
    );
  }
}


//[{
//   'hoy':[
//     notificaines
//   ]
// }]