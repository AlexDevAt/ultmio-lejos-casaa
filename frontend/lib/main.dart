import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/config/app_theme.dart';
import 'package:lejos_de_casa_front/config/di.dart';
import 'package:lejos_de_casa_front/config/router/router.dart';
import 'package:lejos_de_casa_front/presentation/providers/casa/provider_casas.dart';
import 'package:lejos_de_casa_front/presentation/providers/notificacion/provider_notificacion.dart';
import 'package:lejos_de_casa_front/presentation/providers/resenia/provider_resenia.dart';
import 'package:lejos_de_casa_front/presentation/providers/reserva/provider_reserva.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/providers/webSocket/provider_web_socket.dart';
import 'package:lejos_de_casa_front/presentation/screen/test/test_web_socket.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

final channel = IOWebSocketChannel.connect(
  'ws://127.0.0.1:8000/ws/notificacion/GAMM850202MDFDEF02',
);

class GlobalContext {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProviderUsuarios(Di.createUsuarioService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ProviderCasas(Di.createCasaService()),
        ),
        ChangeNotifierProvider.value(value: providerAuthRouter),
        ChangeNotifierProvider(
          create: (_) => ProviderReserva(Di.createReservaService()),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderResenia(Di.createReseniaService()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ProviderNotificacion(Di.createNotificacionService()),
        ),
        ChangeNotifierProxyProvider<ProviderNotificacion, ProviderWebSocket>(
          create: (context) => ProviderWebSocket(),
          update: (context, notifier, previous) {
            final providerActual = previous ?? ProviderWebSocket();
            providerActual.actualizarProviderNotificacion(notifier);
            return providerActual;
          },
        ),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: GlobalContext.messengerKey,
        routerConfig: appRouter,
        theme: AppTheme(selectedColor: 0).getTheme(),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
      ),
    );
  }
}



// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Material App',
//       home: TestWebSocket(),
//     );
//   }
// }