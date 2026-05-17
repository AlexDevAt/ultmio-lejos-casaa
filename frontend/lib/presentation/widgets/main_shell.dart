import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lejos_de_casa_front/domain/entities/menu/item_nav_bar.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});
  final Widget child;

  int _obtenerIndiceAct(String screen) {
    if (screen.startsWith('/busquedaScreen')) return 1;
    if (screen.startsWith('/home')) return 2;
    if (screen.startsWith('/notificaciones')) return 3;
    if (screen.startsWith('/cuenta')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final screenAct = GoRouterState.of(context).uri.toString();
    print(screenAct);
    final index = _obtenerIndiceAct(screenAct);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: index,
        onTap: (value) {
          switch (value) {
            case 1:
              context.go('/busquedaScreen');
              break;
            case 2:
              context.go('/home');
              break;
            case 3:
              context.go('/notificaciones');
              break;
            case 4:
              context.go('/cuenta');
              break;
            case 5:
              context.go('/');
              break;
          }
        },
        items: _ListarMenu(itemsMenu: menuNavBar).listarItems(),
      ),
    );
  }
}

class _ListarMenu {
  final List<ItemNavBar> itemsMenu;

  _ListarMenu({required this.itemsMenu});

  late List<ItemNavBar> items;

  List<BottomNavigationBarItem> listarItems() {
    return itemsMenu
        .map(
          (e) =>
              BottomNavigationBarItem(icon: Icon(e.iconData), label: e.title),
        )
        .toList();
  }
}
