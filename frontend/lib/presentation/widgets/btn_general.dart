import 'package:flutter/material.dart';

class BtnGeneral extends StatelessWidget {
  const BtnGeneral({super.key, required this.onPressed});
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      color: const Color.fromARGB(255, 13, 35, 202),
      iconSize: 60,
      onPressed: onPressed,
      icon: Icon(Icons.arrow_circle_right),
    );
  }
}
