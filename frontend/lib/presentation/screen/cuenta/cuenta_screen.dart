import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/usuario.dart';
import 'package:lejos_de_casa_front/helpers/menu_perfil/menu_perfil.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/widgets/card_icon_label_ListTile.dart';
import 'package:provider/provider.dart';

class CuentaScreen extends StatelessWidget {
  const CuentaScreen({super.key});
  static String name = 'cuenta_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                'Ajustes de la cuenta',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
              ),
              Text(
                'Administra tu cuenta y preferencias',
                style: TextStyle(color: Colors.black45, fontSize: 15),
              ),
            ],
          ),
        ),
      ),

      backgroundColor: Color(0xFFF5F6F8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Text(
                  'GENERAL',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            _BoxMenu(),
          ],
        ),
      ),
    );
  }
}

class _BoxMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Usuario usuarioActual = context.read<ProviderUsuarios>().usuarioActual!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          children: [
            ...menuGeneral.map(
              (opt) => CardIconListTitleCustom(
                url: opt.url,
                title: opt.title,
                icon: opt.icon,
                subtitle: opt.subtitle,
              ),
            ),
            if(usuarioActual.rol == Roles.vendedor)...[
              CardIconListTitleCustom(
                url: '/propiedades',
                title: 'Tus propiedades',
                icon: Icon(Icons.home_outlined),
                subtitle: 'Administra tus propiedades',
              )
            ]
          ],
        ),
      ),
    );
  }
}
