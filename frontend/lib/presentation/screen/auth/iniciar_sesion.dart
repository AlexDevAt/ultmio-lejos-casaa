import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lejos_de_casa_front/helpers/formatos/form_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/providers/auth/provider_auth.dart';
import 'package:lejos_de_casa_front/presentation/providers/casa/provider_casas.dart';
import 'package:lejos_de_casa_front/presentation/providers/notificacion/provider_notificacion.dart';
import 'package:lejos_de_casa_front/presentation/providers/reserva/provider_reserva.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/providers/webSocket/provider_web_socket.dart';
import 'package:lejos_de_casa_front/presentation/widgets/btn_form.dart';
import 'package:provider/provider.dart';

class IniciarSesion extends StatefulWidget {
  const IniciarSesion({super.key});
  static String name = 'auth_screen';
  @override
  State<IniciarSesion> createState() => _IniciarSesionState();
}

class _IniciarSesionState extends State<IniciarSesion> {
  late TextEditingController _correoCtrl;
  late TextEditingController _passCtrl;
  @override
  void initState() {
    super.initState();
    _correoCtrl = TextEditingController();
    _passCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _correoCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  bool correoCorrecto = false;
  bool continuar = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final providerAuth = context.watch<ProviderAuth>();
    final TextStyle textIniciaSesion = const TextStyle(
      inherit: false,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      fontFamily: 'Inter',
    );

    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: _LogoImagen(),
                  ),

                  Center(
                    child: Title(
                      color: Colors.black,
                      child: Text('Inicia sesion', style: textIniciaSesion),
                    ),
                  ),
                  _TextoInfoPadingTop(
                    edgeInsetsGeometry: EdgeInsetsGeometry.only(bottom: 30),
                    top: 30,
                    label:
                        'Ingresa tu correo electronico para iniciar sesion en la aplicacion',
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _CampoTexto(
                          controller: _correoCtrl,
                          validacion: (value) {
                            if (!FormUsuarios.validarEmail(value!)) {
                              return 'Correo invalido';
                            }
                            correoCorrecto = true;
                            return null;
                          },
                          labelText: 'correoelectrónico@dominio.com',
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: (correoCorrecto & continuar) ? 67 : 0,
                          child: _CampoTexto(
                            controller: _passCtrl,
                            validacion: (value) {
                              if (FormUsuarios.contraseniaVacia(value!)) {
                                return 'Ingrese una contrasenia';
                              }
                              return null;
                            }, //TODO Poner validaciones desde el backend
                            labelText: 'Tu password',
                          ),
                        ),
                        BtnFormulario(
                          height: MediaQuery.of(context).size.height * .06,
                          width: double.infinity,
                          text: 'Continuar',
                          func: () async {
                            // <-- Marcamos la función como asíncrona
                            setState(() {
                              continuar = true;
                            });

                            if (_formKey.currentState!.validate()) {
                              // 1. Obtenemos la referencia al provider sin escuchar cambios continuos
                              final authService = context.read<ProviderAuth>();

                              // 2. Esperamos activamente a que termine la petición HTTP
                               authService.login(
                                _correoCtrl.text.trim(),
                                _passCtrl.text,
                                context.read<ProviderUsuarios>(),
                                context.read<ProviderReserva>(),
                                context.read<ProviderCasas>(),
                                context.read<ProviderNotificacion>(),
                                context.read<ProviderWebSocket>(),
                              );

                              // 3. Una vez desbloqueado el hilo, verificamos si el Widget sigue vivo en el árbol
                              if (!context.mounted) return;

                              // 4. Ahora sí, el estado del provider ya cambió con la respuesta del servidor
                              if (authService.error != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      authService.error!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.red.shade400,
                                  ),
                                );
                              } 
                            }
                          }, //TODO HACERLO YO
                        ),
                      ],
                    ),
                  ),
                  _Division(),
                  _LabelCampoForm(
                    textIniciaSesion: textIniciaSesion,
                    label: 'Eres nuevo? Registrate aqui !',
                  ),
                  BtnFormulario(
                    height: MediaQuery.of(context).size.height * .06,
                    width: double.infinity,
                    text: 'Registrarse',
                    func: () => context.push('/register'),
                  ),
                  _TerminosCondiciones(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TerminosCondiciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TextoInfoPadingTop(
          edgeInsetsGeometry: EdgeInsetsGeometry.only(top: 30),
          top: 30,
          label: 'Al hacer click en continuar, aceptas nuestros terminos',
        ),
        Text(
          'Términos de servicio y Política de privacidad',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Inter', color: Color(0xFF1A00FF)),
        ),
      ],
    );
  }
}

class _TextoInfoPadingTop extends StatelessWidget {
  const _TextoInfoPadingTop({
    required this.top,
    required this.label,
    required this.edgeInsetsGeometry,
  });

  final double top;
  final EdgeInsetsGeometry edgeInsetsGeometry;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsetsGeometry,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'Inter'),
      ),
    );
  }
}

class _LabelCampoForm extends StatelessWidget {
  const _LabelCampoForm({
    required this.textIniciaSesion,
    required this.label,
    this.textAlign = TextAlign.center,
  });
  final String label;
  final TextAlign textAlign;
  final TextStyle? textIniciaSesion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(label, textAlign: textAlign, style: textIniciaSesion),
    );
  }
}

class _LogoImagen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: Image.asset('assets/images/app/logo_app.png'),
    );
  }
}

class _CampoTexto extends StatelessWidget {
  const _CampoTexto({
    required this.validacion,
    required this.controller,
    required this.labelText,
  });
  final TextEditingController? controller;
  final String labelText;
  final FormFieldValidator<String> validacion;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),

      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),

          errorBorder: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hint: Text(
            labelText,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        validator: validacion,
      ),
    );
  }
}

class _Division extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Color(0xFFE6E6E6),
              height: 30,
              thickness: 1.4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Text('O'),
          ),
          Expanded(
            child: Divider(
              color: Color(0xFFE6E6E6),
              height: 20,
              thickness: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
