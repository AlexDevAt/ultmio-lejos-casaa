import 'package:flutter/material.dart';



const Color colorIcono = Color(0xFF2F6FD3);

class MenuPerfil {
  final String title;
  final Icon icon;
  final String subtitle;

  MenuPerfil({required this.title, required this.icon, required this.subtitle});
}

final menuGeneral = <MenuPerfil>[
  MenuPerfil(title: 'Gestionar perfil', icon: Icon(Icons.person_2_outlined,color: colorIcono,), subtitle: 'Actualiza tu informacion personal'),
  MenuPerfil(title: 'Reservas', icon: Icon(Icons.home_outlined,color: colorIcono,), subtitle: 'Tus reservas'),
  MenuPerfil(title: 'Historial', icon: Icon(Icons.watch_later_outlined,color: colorIcono,), subtitle: 'Consulta tu actividad reciente'),
  MenuPerfil(title: 'Notificaciones', icon: Icon(Icons.notifications_none_outlined,color: colorIcono,), subtitle: 'Configura tus preferencias'),
  MenuPerfil(title: 'Seguridad y privacidad', icon: Icon(Icons.lock_outlined,color: colorIcono,), subtitle: 'Protege tu cuenta y datos'),
  MenuPerfil(title: 'Ajustes de ubicacion', icon: Icon(Icons.location_on_outlined,color: colorIcono,), subtitle: 'Administra tus ubicaciones'),

];
