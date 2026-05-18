import 'package:flutter/material.dart';

class MapaUbi extends StatelessWidget {
  const MapaUbi({super.key, required this.mapaUrl, required this.size});
  final String mapaUrl;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(8),
      child: Image.asset(height: size.height * .30, fit: BoxFit.cover, mapaUrl),
    );
  }
}
