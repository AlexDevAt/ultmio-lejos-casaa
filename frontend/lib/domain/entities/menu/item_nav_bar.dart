import 'package:flutter/material.dart';

class ItemNavBar {
  final String title;
  final String link;
  final IconData iconData;

  const ItemNavBar({
    required this.title,
    required this.link,
    required this.iconData,
  });
}

const menuNavBar = <ItemNavBar>[
  ItemNavBar(title: 'Proximamente', link: '/', iconData: Icons.people_alt_outlined),
  ItemNavBar(title: 'Busqueda', link: '/busquedaScreen', iconData: Icons.search_outlined),
  ItemNavBar(title: 'Home', link: '/',iconData: Icons.home_outlined ),
  ItemNavBar(title:'Notificaciones', link: '/notificaciones', iconData: Icons.notifications_none),
  ItemNavBar(title: 'Cuenta', link: '/cuenta', iconData: Icons.person_outlined),
];
