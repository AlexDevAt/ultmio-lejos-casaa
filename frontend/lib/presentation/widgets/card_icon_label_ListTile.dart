
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lejos_de_casa_front/presentation/widgets/icono_custom.dart';
class CardIconListTitleCustom extends StatelessWidget {
  final String title;
  final Icon icon;
  final String subtitle;
  final String url;
  const CardIconListTitleCustom({super.key, 

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