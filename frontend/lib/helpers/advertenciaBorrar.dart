import 'package:flutter/material.dart';

const List<String> camposProhibidos = ['Nombres', 'Apellidos', 'Curp'];

Future<String?> dialogBorrarUsuario({
  required BuildContext context,
  required String curp,
}) async {


  final result = await showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: Text('ADVERTENCIA SE BORRARA EL REGISTRO DEL USUARIO $curp'),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Aceptar'),
        ),
      ],
    ),
  );

  return result;
}
