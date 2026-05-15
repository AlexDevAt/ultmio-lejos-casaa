import 'package:flutter/material.dart';

class BtnFormulario extends StatelessWidget {
  const BtnFormulario({
    super.key,
    required this.text,
    required this.func,
    required this.width,
    required this.height,
    this.color, this.vertical, this.horizontal,
  });

  final String text;
  final VoidCallback func;
  final double width;
  final double height;
  final Color? color;
  final double? vertical;
  final double? horizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Color(0xFF0b1636),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        onPressed: func,
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: vertical ?? 12,horizontal: horizontal ?? 12),
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
