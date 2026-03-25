import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lejos_de_casa_front/domain/entities/usuario.dart';
import 'package:lejos_de_casa_front/helpers/formatos/form_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:provider/provider.dart';

class CrearUsuario extends StatelessWidget {
  const CrearUsuario({super.key});
  static String name = 'crear_usuario_screen';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Title(
            color: Colors.black,
            child: Text('Registro', style: TextStyle(fontSize: 27)),
          ),
          Formulario(),
        ],
      ),
    );
  }
}

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();

  final controllerNombre = TextEditingController();
  final correoController = TextEditingController();
  final numeroController = TextEditingController();
  final calleController = TextEditingController();
  final numExtController = TextEditingController();
  final codigoPController = TextEditingController();
  final ciudadController = TextEditingController();
  final municipioController = TextEditingController();
  final curpController = TextEditingController();
  final apellidosController = TextEditingController();
  final contraController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerNombre.dispose();
    correoController.dispose();
    numeroController.dispose();
    calleController.dispose();
    numExtController.dispose();
    codigoPController.dispose();
    ciudadController.dispose();
    municipioController.dispose();
    apellidosController.dispose();
    contraController.dispose();
    curpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provUsuario = context.watch<ProviderUsuarios>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _CampoTexto(
            controller: controllerNombre,
            campo: 'Nombre',
            prefixIcon: Icons.person,
            validacion: (value) {
              if (!FormUsuarios.validarTexto(value!)) {
                return 'Ingrese un nombre';
              }
              return null;
            },
          ),
          _CampoTexto(
            controller: apellidosController,
            campo: 'Apellidos',

            prefixIcon: Icons.person,
            validacion: (value) {
              if (!FormUsuarios.validarTexto(value!)) {
                return 'Ingresa tu apellido';
              }
              return null;
            },
          ),
          _CampoTexto(
            controller: correoController,
            campo: 'Correo electornico',
            formatoEsp: false,
            prefixIcon: Icons.email,
            validacion: (value) {
              if (!FormUsuarios.validarEmail(value!)) {
                return 'Ingrese un correo valido';
              }
              return null;
            },
          ),
          _CampoTexto(
            controller: contraController,
            campo: 'Contrasenia',
            formatoEsp: false,
            prefixIcon: Icons.password,
            validacion: (value) {
              return null;
            },
          ),
          _CampoTexto(
            controller: numeroController,
            campo: 'Telefono',
            prefixIcon: Icons.phone_android,
            formatoEsp: false,
            validacion: (value) {
              if (!FormUsuarios.validarTelefon(value!)) {
                return 'Ingrese un telefono valido';
              }
              return null;
            },
          ),
          _CampoTexto(
            controller: calleController,
            campo: 'calle',
            prefixIcon: Icons.numbers,
            validacion: (value) {
              if (!FormUsuarios.validarTexto(value!)) {
                return 'Ingresa tu calle';
              }
              return null;
            },
          ),
          _CampoTexto(
            controller: numExtController,
            campo: 'tu numero exterior',
            formatoEsp: false,
            prefixIcon: Icons.numbers,
            validacion: (value) {
              if (!FormUsuarios.validarTexto(value!)) {
                return 'Ingresa tu numero exterior';
              }
              return null;
            },
          ),
          _CampoTexto(
            controller: codigoPController,
            campo: 'Codigo postal',
            formatoEsp: false,
            prefixIcon: Icons.numbers,
            validacion: (value) {
              if (!FormUsuarios.validarTexto(value!)) {
                return 'Ingrese un codigo postal valido';
              }
              return null;
            },
          ),
          _CampoTexto(
            controller: ciudadController,
            campo: 'Ciudad',
            prefixIcon: Icons.map_outlined,
            validacion: (value) {
              if (!FormUsuarios.validarTexto(value!)) {
                return 'Ingrese una ciudad valida';
              }
              return null;
            },
          ),
          _CampoTexto(
            controller: municipioController,
            campo: 'Municipio',
            prefixIcon: Icons.maps_home_work_outlined,
            validacion: (value) {
              if (!FormUsuarios.validarTexto(value!)) {
                return 'Ingrese un municipio valido';
              }
              return null;
            },
          ),
          _CampoTexto(
            controller: curpController,
            campo: 'Curp',
            formatoEsp: false,
            prefixIcon: Icons.person_pin_rounded,
            validacion: (value) {
              if (!FormUsuarios.validarTexto(value!)) {
                return 'Ingrese una curp valida';
              }
              return null;
            },
          ),

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final usuario = Usuario(
      curp: curpController.text.trim(),
      nombres: controllerNombre.text.trim(),
      apellidos: apellidosController.text.trim(),
      correo: correoController.text.trim(),
      telefono: numeroController.text.trim(),
      contrasenia: contraController.text.trim(),
      rol: Roles.comprador,
      fechaRegistro: DateTime.now(),
      calle: calleController.text.trim(),
      numeroInterior: int.tryParse(numExtController.text.trim()) ?? 0,
      codigoPostal: codigoPController.text.trim(),
      municipio: municipioController.text.trim(),
      ciudad: ciudadController.text.trim(),
    );

     provUsuario.crearUsuario(usuario);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Registro exitoso')));
              }
            },
            child: Text('Registrar'),
          ),
        ],
      ),
    );
  }
}

class _CampoTexto extends StatelessWidget {
  const _CampoTexto({
    required this.campo,
    required this.prefixIcon,
    required this.validacion,
    this.formatoEsp = true,
    required this.controller,
  });
  final TextEditingController controller;
  final IconData prefixIcon;
  final String campo;
  final FormFieldValidator<String> validacion;
  final bool formatoEsp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: TextFormField(
        controller: controller,
        autofocus: campo == true,
        inputFormatters: formatoEsp == false
            ? []
            : [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]'),
                ),
              ],
        style: TextStyle(fontSize: 20),

        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23),
            gapPadding: 10,
          ),
          prefixIcon: Icon(prefixIcon),
          labelText: campo,
        ),
        validator: validacion,
      ),
    );
  }
}

