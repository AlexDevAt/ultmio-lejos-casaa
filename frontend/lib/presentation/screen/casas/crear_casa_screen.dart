import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/domain/entities/propietario.dart';
import 'package:lejos_de_casa_front/domain/entities/region.dart';
import 'package:lejos_de_casa_front/domain/entities/usuario.dart';
import 'package:lejos_de_casa_front/infrastructure/models/casa/casa_model.dart';
import 'package:lejos_de_casa_front/presentation/providers/casa/provider_casas.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:provider/provider.dart';

class CrearCasa extends StatelessWidget {
  const CrearCasa({super.key});
  static String name = 'crear_casa_screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text('Registrar Casa', style: TextStyle(fontSize: 27)),
              FormularioCasa(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormularioCasa extends StatefulWidget {
  const FormularioCasa({super.key});

  @override
  State<FormularioCasa> createState() => _FormularioCasaState();
}

class _FormularioCasaState extends State<FormularioCasa> {
  late final _formKey = GlobalKey<FormState>();
  late final tituloController;
  late final tipoController;
  late final cupoController;
  late final cuartosController;
  late final calleController;
  late final numInteriorController;
  late final codigoPostalController;
  late final estadoController;
  late final municipioController;
  late final precioController;
  late final Usuario providerUsuarioActual;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    providerUsuarioActual = context.read<ProviderUsuarios>().usuarioActual!;
    tituloController = TextEditingController();
    tipoController = TextEditingController();
    cupoController = TextEditingController();
    cuartosController = TextEditingController();
    calleController = TextEditingController();
    numInteriorController = TextEditingController();
    codigoPostalController = TextEditingController();
    estadoController = TextEditingController();
    municipioController = TextEditingController();
    precioController = TextEditingController();
  }

  @override
  void dispose() {
    tituloController.dispose();
    tipoController.dispose();
    cupoController.dispose();
    cuartosController.dispose();
    calleController.dispose();
    numInteriorController.dispose();
    codigoPostalController.dispose();
    precioController.dispose();
    super.dispose();
  }

  String? validarTexto(String? value, String campo) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa $campo';
    }
    return null;
  }

  String? validarEntero(String? value, String campo) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa $campo';
    }
    if (int.tryParse(value.trim()) == null) {
      return '$campo debe ser numero';
    }
    return null;
  }

  String? validarDecimal(String? value, String campo) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa $campo';
    }
    if (double.tryParse(value.trim()) == null) {
      return '$campo debe ser valido';
    }
    return null;
  }

  TipoCasa mapearTipoCasa(String tipo) {
    final t = tipo.trim().toLowerCase();

    if (t == 'una planta' || t == 'un piso' || t == 'unaplanta') {
      return TipoCasa.unaPlanta;
    }

    if (t == 'dos plantas' || t == 'dos pisos' || t == 'dosplantas') {
      return TipoCasa.dosPlantas;
    }

    return TipoCasa.otroTipo;
  }

  @override
  Widget build(BuildContext context) {
    final providerCasa = context.watch<ProviderCasas>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _CampoTexto(
            controller: tituloController,
            campo: 'Titulo',
            prefixIcon: Icons.home,
            validacion: (value) => validarTexto(value, 'el titulo'),
          ),
          _CampoTexto(
            controller: tipoController,
            campo: 'Tipo de casa',
            prefixIcon: Icons.house,
            validacion: (value) => validarTexto(value, 'el tipo'),
          ),
          _CampoTexto(
            controller: cupoController,
            campo: 'Cupo',
            prefixIcon: Icons.people,
            keyboardType: TextInputType.number,
            validacion: (value) => validarEntero(value, 'el cupo'),
          ),
          _CampoTexto(
            controller: cuartosController,
            campo: 'Cuartos',
            prefixIcon: Icons.bed,
            keyboardType: TextInputType.number,
            validacion: (value) => validarEntero(value, 'los cuartos'),
          ),
          _CampoTexto(
            controller: calleController,
            campo: 'Calle',
            prefixIcon: Icons.map,
            validacion: (value) => validarTexto(value, 'la calle'),
          ),
          _CampoTexto(
            controller: numInteriorController,
            campo: 'Numero interior',
            prefixIcon: Icons.numbers,
            keyboardType: TextInputType.number,
            validacion: (value) => validarEntero(value, 'el numero interior'),
          ),
          _CampoTexto(
            controller: codigoPostalController,
            campo: 'Codigo postal',
            prefixIcon: Icons.location_on,
            validacion: (value) => validarTexto(value, 'el codigo postal'),
          ),
          _CampoTexto(
            controller: estadoController,
            campo: 'Estado',
            prefixIcon: Icons.location_on,
            validacion: (value) => validarTexto(value, 'Estado '),
          ),
          _CampoTexto(
            controller: municipioController,
            campo: 'Municipio',
            prefixIcon: Icons.location_on,
            validacion: (value) => validarTexto(value, 'Municipio'),
          ),
          _CampoTexto(
            controller: precioController,
            campo: 'Precio',
            prefixIcon: Icons.attach_money,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validacion: (value) => validarDecimal(value, 'el precio'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;
              final casa = Casa(
                id: 0,
                titulo: tituloController.text.trim(),
                cupo: int.parse(cupoController.text.trim()),
                tipo: tipoCasaFromString(tipoController.text),
                imagen: 'img1.jpg',
                cuartos: int.parse(cuartosController.text.trim()),
                calle: calleController.text.trim(),
                numInterior: int.parse(numInteriorController.text.trim()),
                precio: double.parse(precioController.text.trim()),
                idPropietario: providerUsuarioActual.curp,
                idRegion:  codigoPostalController.text,
              );
              providerCasa.crearCasa(casa);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Casa registrada')));
            },
            child: const Text('Registrar'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _CampoTexto extends StatelessWidget {
  const _CampoTexto({
    required this.controller,
    required this.campo,
    required this.prefixIcon,
    required this.validacion,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String campo;
  final IconData prefixIcon;
  final FormFieldValidator<String> validacion;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(23)),
          prefixIcon: Icon(prefixIcon),
          labelText: campo,
        ),
        validator: validacion,
      ),
    );
  }
}
