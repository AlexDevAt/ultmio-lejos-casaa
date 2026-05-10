import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lejos_de_casa_front/helpers/menu_perfil/menu_perfil.dart';
import 'package:lejos_de_casa_front/presentation/widgets/icono_custom.dart';

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
              (opt) => _CardOpcion(
                url: opt.url,
                title: opt.title,
                icon: opt.icon,
                subtitle: opt.subtitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardOpcion extends StatelessWidget {
  final String title;
  final Icon icon;
  final String subtitle;
  final String url;
  const _CardOpcion({
    required this.title,
    required this.icon,
    required this.subtitle, required this.url,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => context.push(url),
          leading: IconoOpcion(
            icon: icon,
            color: Color(0xFFDCEBFF),
            sizeBorder: 15,
            height: 52,
            width: 52,
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.arrow_forward_ios_sharp),
        ),
        SizedBox(height: 10),
        Divider(thickness: 1, color: Colors.black26),
        SizedBox(height: 10),
      ],
    );
  }
}

// class _CardOpcion extends StatelessWidget {
//   final String title;
//   final Icon icon;
//   final String subtitle;
//   const _CardOpcion({required this.title, required this.icon, required this.subtitle});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             _IconoOpcion(icon: Icons.person_2_outlined),
//             SizedBox(width: 15),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 Text(
//                   subtitle,
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ],
//             ),

//             Expanded(
//               child: IconButton(
//                 onPressed: () => (),
//                 icon: Icon(Icons.arrow_forward_ios_rounded),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 10,),
//         Divider(thickness: .2,),
//         SizedBox(height: 10,),

//       ],
//     );
//   }
// }
