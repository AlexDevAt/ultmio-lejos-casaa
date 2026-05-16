import 'package:flutter/material.dart';
class ImagenCasa extends StatelessWidget {
  const ImagenCasa({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Container(
        width: size.width * .85,
        height: size.height * .20,
        child: ClipRRect(child: Image.asset('assets/images/casas/$imageUrl')),
      ),
    );
  }
}