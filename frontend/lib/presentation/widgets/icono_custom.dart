import 'package:flutter/material.dart';

class IconoOpcion extends StatelessWidget {
  final Icon icon;
  final Color color;
  final double sizeBorder;
  final double height;
  final double width;
  const IconoOpcion({
    super.key,
    required this.icon,
    required this.color,
    required this.sizeBorder, required this.height, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
        color: color,
        borderRadius: BorderRadius.circular(sizeBorder),
      ),
      height: height,
      width: width,
      child: icon,
    );
  }
}
