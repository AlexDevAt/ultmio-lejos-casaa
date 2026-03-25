import 'package:flutter/material.dart';

const List<String> camposProhibidos = ['Nombres', 'Apellidos', 'Curp'];

Future<String?> dialogEditarCampo({
  required BuildContext context,
  required String titulo,
  required String valorInicial,
}) async {
  final controller = TextEditingController(text: valorInicial);

  bool isProhibido(String campo) {
    return camposProhibidos.contains(campo);
  }

  final campoNo = isProhibido(titulo);

  if (campoNo) {
    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Campo bloqueado'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
    return null;
  }

  final result = await showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: Text('Editar $titulo'),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(hintText: 'Nuevo $titulo'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            final nuevo = controller.text.trim();
            Navigator.pop(context, nuevo.isEmpty ? null : nuevo);
          },
          child: const Text('Guardar'),
        ),
      ],
    ),
  );

  return result;
}
