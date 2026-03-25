import 'package:flutter/material.dart';

class BtnCustom extends StatelessWidget {
  const BtnCustom({super.key, required this.texto, this.color, this.ontap});
  final String texto;
  final Color? color;
  final VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: color,
        child: InkWell(
          onTap: ontap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              texto,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
