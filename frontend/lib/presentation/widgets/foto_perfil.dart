import 'package:flutter/material.dart';

class FotoPerfil extends StatelessWidget {
  const FotoPerfil({super.key, required this.color, this.sizeIcon, this.height, this.width});
  final Color color;
  final double? height;
  final double? width;
  final double? sizeIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 120,
      width: width ?? 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(child: Icon(Icons.person, size: sizeIcon ?? 100)),
    );
  }
}
