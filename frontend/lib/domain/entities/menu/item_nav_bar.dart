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
  ItemNavBar(title: 'Usuarios', link: '/usuarios', iconData: Icons.people_alt_outlined),
  ItemNavBar(title: 'Casas', link: '/casas', iconData: Icons.home_outlined),
  ItemNavBar(title: 'Busqueda', link: '/busqueda', iconData: Icons.search_outlined),
  ItemNavBar(title:'Reservas', link: '/reservas', iconData: Icons.confirmation_num_outlined),
  ItemNavBar(title: 'Cuenta', link: '/cuenta', iconData: Icons.person_outlined),
];
