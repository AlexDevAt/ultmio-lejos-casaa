import 'package:flutter/material.dart';

class Puntuacion extends StatelessWidget {
  const Puntuacion({super.key, this.sizeIcon});
  final double? sizeIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber,size: sizeIcon ?? 24,),
        Icon(Icons.star, color: Colors.amber,size: sizeIcon ?? 24),
        Icon(Icons.star, color: Colors.amber,size: sizeIcon ?? 24),
        Icon(Icons.star, color: Colors.amber,size: sizeIcon ?? 24),
        Icon(Icons.star, color: Colors.grey.shade400,size: sizeIcon ?? 24),
      ],
    );
  }
}
