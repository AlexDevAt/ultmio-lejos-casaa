import 'package:go_router/go_router.dart';
import 'package:lejos_de_casa_front/domain/entities/usuario.dart';
import 'package:lejos_de_casa_front/presentation/screen/auth/iniciar_sesion.dart';
import 'package:lejos_de_casa_front/presentation/screens.dart';
import 'package:lejos_de_casa_front/presentation/widgets/main_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/home',

  routes: [
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [

        // GoRoute(
        //   path: '/usuarios',
        //   name: AllUsersScreen.name,
        //   builder: (context, state) => const AllUsersScreen(),
        //   routes: [
        //     GoRoute(
        //       path: 'infoUsuario', // => /usuarios/infoUsuario
        //       name: 'infoUsuario',
        //       builder: (context, state) {
        //         final usuario = state.extra as Usuario;
        //         return InfoUsuario(usuario: usuario);
        //       },
        //     ),
        //   ],
        // ),
        GoRoute(
          path: '/perfilUsuario' ,
          name: PerfilUsuario.name,
          builder: (context, state) => const PerfilUsuario(),
        ),
        GoRoute(
          path: '/' ,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/auth',
          name: IniciarSesion.name,
          builder: (context, state) => const IniciarSesion(),
        ),
        GoRoute(
          path: '/home' ,
          name: HomeScreen.name,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/reservas',
          name: ReservasScreen.name,
          builder: (context, state) => const ReservasScreen(),
        ),
         GoRoute(
          path: '/cuenta',
          name: CuentaScreen.name,
          builder: (context, state) => const CuentaScreen(),
        ),
        GoRoute(
          path: '/crearCasa',
          name: CrearCasa.name,
          builder: (context, state) => const CrearCasa(),
        ),
      ],
    ),
  ],
);
