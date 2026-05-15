import 'package:flutter/material.dart';

class ReseniasCompletas extends StatelessWidget {
  const ReseniasCompletas({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Resenias',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
        ),
      ),
    );
  }
}