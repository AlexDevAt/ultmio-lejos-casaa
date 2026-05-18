import 'package:go_router/go_router.dart';
import 'package:lejos_de_casa_front/config/di.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/domain/entities/propietario.dart';
import 'package:lejos_de_casa_front/presentation/providers/auth/provider_auth.dart';
import 'package:lejos_de_casa_front/presentation/screen/casas/info_casa.dart';
import 'package:lejos_de_casa_front/presentation/screen/home/home_screen.dart';
import 'package:lejos_de_casa_front/presentation/screen/notificacion/notificaciones_screen.dart';
import 'package:lejos_de_casa_front/presentation/screen/usuarios/propietario_info.dart';
import 'package:lejos_de_casa_front/presentation/screen/usuarios/register_usuario.dart';
import 'package:lejos_de_casa_front/presentation/screens.dart';
import 'package:lejos_de_casa_front/presentation/widgets/main_shell.dart';

final providerAuthRouter = ProviderAuth(Di.createAuthService());
final appRouter = GoRouter(
  // refreshListenable: providerAuthRouter,
  // redirect: (context, state) {
  //   if (!providerAuthRouter.logueado) {
  //     return '/auth';
  //   }
  //   if (state.matchedLocation == '/auth') {
  //     return '/home';
  //   } else {
  //     return null;
  //   }
  // },
  initialLocation: '/registrar_casa',

  // initialLocation: '/register',
  routes: [
    GoRoute(
      path: '/auth',
      name: IniciarSesion.name,
      builder: (context, state) => const IniciarSesion(),
    ),
     GoRoute(
      path: '/registrar_casa',
      name: CrearCasa.name,
      builder: (context, state) => const CrearCasa(),
    ),
    

    GoRoute(
      path: '/register',
      name: RegisterUsuario.name,
      builder: (context, state) => const RegisterUsuario(),
    ),
    GoRoute(
      path: '/infoCasa',
      name: InfoCasa.name,
      builder: (context, state) {
        final casa = state.extra as Casa;
        return InfoCasa(casa: casa);
      },
    ),
    GoRoute(
      path: '/propietarioInfo',
      name: PropietarioInfo.name,
      builder: (context, state) {
        final Propietario propietario = state.extra as Propietario;
        return PropietarioInfo(propietario: propietario,);
      },
    ),
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/perfilUsuario',
          name: PerfilUsuario.name,
          builder: (context, state) => const PerfilUsuario(),
        ),
        GoRoute(
          path: '/notificaciones',
          name: NotificacionesScreen.name,
          builder: (context, state) => const NotificacionesScreen(),
        ),
        GoRoute(
          path: '/reservas',
          name: ReservasScreen.name,
          builder: (context, state) => const ReservasScreen(),
        ),
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/busquedaScreen',
          name: BusquedaScreen.name,
          builder: (context, state) => const BusquedaScreen(),
        ),
        GoRoute(
          path: '/home',
          name: HomeScreen.name,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/cuenta',
          name: CuentaScreen.name,
          builder: (context, state) => const CuentaScreen(),
        ),
       
      ],
    ),
  ],
);
