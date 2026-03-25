import 'package:flutter/material.dart';

class BtnFormulario extends StatelessWidget {
  const BtnFormulario({super.key, required this.text, required this.func, required this.width,  this.height = 0});

  final String text;
  final VoidCallback func;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF0b1636),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        onPressed: func,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
