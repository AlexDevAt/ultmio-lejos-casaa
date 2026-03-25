import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/config/app_theme.dart';
import 'package:lejos_de_casa_front/config/di.dart';
import 'package:lejos_de_casa_front/config/router/router.dart';
import 'package:lejos_de_casa_front/presentation/providers/casa/provider_casas.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/screen/auth/iniciar_sesion.dart';
import 'package:lejos_de_casa_front/presentation/screen/casas/crear_casa_screen.dart';
import 'package:lejos_de_casa_front/presentation/screen/usuarios/all_users_screen.dart';
import 'package:lejos_de_casa_front/presentation/screens.dart';
import 'package:provider/provider.dart';

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
          create: (_) => ProviderCasas(Di.createCasaService()))
      ],
      child: MaterialApp.router(
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
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ProviderCasas(Di.createCasaService())),
//       ],
//       child: MaterialApp(
//   title: 'Material App',
//       home: CrearCasa())
//       );
//   }
// }

// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: CrearCasaScreen());
//   }
// }
