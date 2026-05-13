import 'package:flutter/material.dart';

class RegisterUsuario extends StatelessWidget {
  const RegisterUsuario({super.key});
  static const name = 'register_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topStart,
            end: AlignmentGeometry.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0x99999999)],
            stops: [.30, .90],
          ),
        ),
      ),
    );
  }
}

class _FormularioContainer extends StatelessWidget {
  const _FormularioContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      height: double.infinity,
    );
  }
}
