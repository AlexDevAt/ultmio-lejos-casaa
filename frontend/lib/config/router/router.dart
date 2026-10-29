import 'package:go_router/go_router.dart';
import 'package:lejos_de_casa_front/config/di.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/domain/entities/propietario.dart';
import 'package:lejos_de_casa_front/domain/entities/reserva.dart';
import 'package:lejos_de_casa_front/presentation/providers/auth/provider_auth.dart';
import 'package:lejos_de_casa_front/presentation/screen/casas/info_casa.dart';
import 'package:lejos_de_casa_front/presentation/screen/home/home_screen.dart';
import 'package:lejos_de_casa_front/presentation/screen/notificacion/notificaciones_screen.dart';
import 'package:lejos_de_casa_front/presentation/screen/propiedades/detalle_propiedad.dart';
import 'package:lejos_de_casa_front/presentation/screen/propiedades/propiedades_screen.dart';
import 'package:lejos_de_casa_front/presentation/screen/reservas/detalle_reserva.dart';
import 'package:lejos_de_casa_front/presentation/screen/usuarios/propietario_info.dart';
import 'package:lejos_de_casa_front/presentation/screen/usuarios/register_usuario.dart';
import 'package:lejos_de_casa_front/presentation/screens.dart';
import 'package:lejos_de_casa_front/presentation/widgets/main_shell.dart';

final providerAuthRouter = ProviderAuth(Di.createAuthService());
final appRouter = GoRouter(
  refreshListenable: providerAuthRouter,
  redirect: (context, state) {
  final ubiActual = state.matchedLocation;
  final estaLogueado = providerAuthRouter.logueado;


  if (estaLogueado) {
    if (ubiActual == '/auth' || ubiActual == '/register') {
      return '/home';
    }
    return null; 
  }

  if (ubiActual == '/auth' || ubiActual == '/register') {
    return null;
  }

  return '/auth';
},//TODO hacerlo yo
//   redirect: (context, state) {

//   if (state.matchedLocation == '/auth' || state.matchedLocation == '/register') {
//     return null;
//   }

//   if (!providerAuthRouter.logueado) {
//     return '/auth';
//   }

//   if (providerAuthRouter.logueado) return null;
//   return null;
// },
  initialLocation: '/home',

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
      name: CrearUsuario.name,
      builder: (context, state) => const CrearUsuario(),
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
        return PropietarioInfo(propietario: propietario);
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
      path: '/detallePropiedad',
      name: PropertyDetailScreen.name,
      builder: (context, state) {
        final Casa propietario = state.extra as Casa;
        return PropertyDetailScreen(casa: propietario,);
      },
    ),GoRoute(
      path: '/detalleReserva',
      name: BookingDetailScreen.name,
      builder: (context, state) {
        final Reserva reserva = state.extra as Reserva;
        return BookingDetailScreen(reserva: reserva,);
      },
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
        GoRoute(
          path: '/propiedades',
          name: PropiedadesScreen.name,
          builder: (context, state) => const PropiedadesScreen(),
        )
      ],
    ),
  ],
);
