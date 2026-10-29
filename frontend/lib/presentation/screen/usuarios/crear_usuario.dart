import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lejos_de_casa_front/domain/entities/usuario.dart';
import 'package:lejos_de_casa_front/helpers/formatos/form_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:provider/provider.dart';

class CrearUsuario extends StatelessWidget {
  const CrearUsuario({super.key});

  static String name = 'crear_usuario_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0xFFD9D9D9)],
            stops: [.15, .90],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: SizedBox(
                    height: 120,
                    child: Image.asset('assets/images/app/logo_app.png'),
                  ),
                ),
                const Text(
                  '¡Bienvenido!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    color: Colors.black,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 30),
                  child: Text(
                    'Completa los campos solicitados para comenzar con la experiencia',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      color: Colors.black,
                    ),
                  ),
                ),
                const Formulario(),
                const _TerminosCondiciones(),
              ],
            ),
          ),
        ),
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

  late TextEditingController _nombreCtrl;
  late TextEditingController _apellidoPatCtrl;
  late TextEditingController _apellidoMatCtrl;
  late TextEditingController _correoCtrl;
  late TextEditingController _telefonoCtrl;
  late TextEditingController _curpCtrl;
  late TextEditingController _fechaNacCtrl;
  late TextEditingController _ciudadCtrl;
  late TextEditingController _municipioCtrl;
  late TextEditingController _codigoPCtrl;
  late TextEditingController _calleCtrl;
  late TextEditingController _numIntCtrl;
  late TextEditingController _contraCtrl;

  DateTime? _fechaSeleccionada;

  @override
  void initState() {
    super.initState();
    _nombreCtrl = TextEditingController();
    _apellidoPatCtrl = TextEditingController();
    _apellidoMatCtrl = TextEditingController();
    _correoCtrl = TextEditingController();
    _telefonoCtrl = TextEditingController();
    _curpCtrl = TextEditingController();
    _fechaNacCtrl = TextEditingController();
    _ciudadCtrl = TextEditingController();
    _municipioCtrl = TextEditingController();
    _codigoPCtrl = TextEditingController();
    _calleCtrl = TextEditingController();
    _numIntCtrl = TextEditingController();
    _contraCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _apellidoPatCtrl.dispose();
    _apellidoMatCtrl.dispose();
    _correoCtrl.dispose();
    _telefonoCtrl.dispose();
    _curpCtrl.dispose();
    _fechaNacCtrl.dispose();
    _ciudadCtrl.dispose();
    _municipioCtrl.dispose();
    _codigoPCtrl.dispose();
    _calleCtrl.dispose();
    _numIntCtrl.dispose();
    _contraCtrl.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? seleccionado = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0A1128),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (seleccionado != null) {
      setState(() {
        _fechaSeleccionada = seleccionado;
        _fechaNacCtrl.text =
            "${seleccionado.year}-${seleccionado.month.toString().padLeft(2, '0')}-${seleccionado.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _CampoTexto(
            controller: _nombreCtrl,
            labelText: 'Nombres',
            validacion: (v) => (!FormUsuarios.validarTexto(v!))
                ? 'Ingrese un nombre válido'
                : null,
          ),
          _CampoTexto(
            controller: _apellidoPatCtrl,
            labelText: 'Apellido paterno',
            validacion: (v) => (!FormUsuarios.validarTexto(v!))
                ? 'Ingrese el apellido paterno'
                : null,
          ),
          _CampoTexto(
            controller: _apellidoMatCtrl,
            labelText: 'Apellido materno',
            validacion: (v) => (!FormUsuarios.validarTexto(v!))
                ? 'Ingrese el apellido materno'
                : null,
          ),
          _CampoTexto(
            controller: _correoCtrl,
            labelText: 'Correo electrónico',
            formatoLetras: false,
            validacion: (v) => (!FormUsuarios.validarEmail(v!))
                ? 'Ingrese un correo válido'
                : null,
          ),
          _CampoTexto(
            controller: _telefonoCtrl,
            labelText: 'Número de teléfono',
            formatoLetras: false,
            keyboardType: TextInputType.phone,
            validacion: (v) => (!FormUsuarios.validarTelefon(v!))
                ? 'Ingrese un teléfono válido'
                : null,
          ),
          _CampoTexto(
            controller: _curpCtrl,
            labelText: 'CURP (18 caracteres)',
            formatoLetras: false,
            textCapitalization: TextCapitalization.characters,
            validacion: (v) => (v == null || v.trim().length != 18)
                ? 'La CURP debe tener 18 caracteres'
                : null,
          ),
          _CampoTexto(
            controller: _fechaNacCtrl,
            labelText: 'Fecha de nacimiento',
            readOnly: true,
            suffixIcon: const Icon(Icons.calendar_month, color: Colors.black54),
            onTap: () => _seleccionarFecha(context),
            validacion: (v) => (v == null || v.isEmpty)
                ? 'Seleccione su fecha de nacimiento'
                : null,
          ),
          _CampoTexto(
            controller: _ciudadCtrl,
            labelText: 'Ciudad',
            validacion: (v) =>
                (!FormUsuarios.validarTexto(v!)) ? 'Ingrese una ciudad' : null,
          ),
          _CampoTexto(
            controller: _municipioCtrl,
            labelText: 'Municipio',
            validacion: (v) => (!FormUsuarios.validarTexto(v!))
                ? 'Ingrese un municipio'
                : null,
          ),
          _CampoTexto(
            controller: _codigoPCtrl,
            labelText: 'Código postal',
            formatoLetras: false,
            keyboardType: TextInputType.number,
            validacion: (v) =>
                (v == null || v.isEmpty) ? 'Ingrese un código postal' : null,
          ),
          _CampoTexto(
            controller: _calleCtrl,
            labelText: 'Calle',
            formatoLetras: false,
            validacion: (v) =>
                (v == null || v.isEmpty) ? 'Ingrese la calle' : null,
          ),
          _CampoTexto(
            controller: _numIntCtrl,
            labelText: 'Número interior / exterior',
            formatoLetras: false,
            validacion: (v) => (v == null || v.isEmpty)
                ? 'Ingrese el número de vivienda'
                : null,
          ),
          _CampoTexto(
            controller: _contraCtrl,
            labelText: 'Contraseña',
            formatoLetras: false,
            obscureText: true,
            validacion: (v) =>
                (v == null || v.isEmpty) ? 'Defina una contraseña' : null,
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .06,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final apellidosUnificados =
                      "${_apellidoPatCtrl.text.trim()} ${_apellidoMatCtrl.text.trim()}";

                  final usuario = Usuario(
                    curp: _curpCtrl.text.trim().toUpperCase(),
                    nombres: _nombreCtrl.text.trim(),
                    apellidos: apellidosUnificados,
                    correo: _correoCtrl.text.trim(),
                    telefono: _telefonoCtrl.text.trim(),
                    contrasenia: _contraCtrl.text.trim(),
                    rol: Roles.comprador,
                    fechaRegistro: DateTime.now(),
                    calle: _calleCtrl.text.trim(),
                    numeroInterior: int.tryParse(_numIntCtrl.text.trim()) ?? 0,
                    codigoPostal: _codigoPCtrl.text.trim(),
                    municipio: _municipioCtrl.text.trim(),
                    ciudad: _ciudadCtrl.text.trim(),
                  );

                  await context.read<ProviderUsuarios>().crearUsuario(usuario);

                  if (context.mounted) {
                    if (context.read<ProviderUsuarios>().error == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Registro exitoso',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: Colors.green.shade200,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            context.read<ProviderUsuarios>().error!,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red.shade400,
                        ),
                      );
                    }
                    if (context.read<ProviderUsuarios>().error == null) {
                      context.pop();
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A1128),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CampoTexto extends StatelessWidget {
  const _CampoTexto({
    required this.labelText,
    required this.controller,
    required this.validacion,
    this.formatoLetras = true,
    this.readOnly = false,
    this.obscureText = false,
    this.suffixIcon,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String> validacion;
  final bool formatoLetras;
  final bool readOnly;
  final bool obscureText;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        inputFormatters: formatoLetras
            ? [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]'),
                ),
              ]
            : [],
        style: const TextStyle(
          fontSize: 15,
          fontFamily: 'Inter',
          color: Colors.black,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: labelText,
          hintStyle: const TextStyle(
            fontSize: 15,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            color: Colors.black54,
          ),
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
          ),
        ),
        validator: validacion,
      ),
    );
  }
}

class _TerminosCondiciones extends StatelessWidget {
  const _TerminosCondiciones();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 10),
      child: Column(
        children: [
          const Text(
            'Al hacer clic en continuar, aceptas nuestros',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          GestureDetector(
            onTap: () {}, // TODO: Implementar navegación a términos
            child: const Text(
              'Términos de servicio y Política de privacidad',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: Color(0xFF1A00FF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
