import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/helpers/formatos/form_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/widgets/btn_form.dart';

class IniciarSesion extends StatefulWidget {
  const IniciarSesion({super.key});
    static String name = 'auth_screen';


  @override
  State<IniciarSesion> createState() => _IniciarSesionState();
}

//todo: Falta manda el formulario al back para revisarlo

class _IniciarSesionState extends State<IniciarSesion> {
  bool correoCorrecto = false;
  bool continuar = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final TextStyle? textIniciaSesion = TextStyle(
      inherit: false,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      fontFamily: 'Inter',
    );

    final TextStyle? textInfoIniciar = TextStyle(
      inherit: false,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      fontFamily: 'Inter',
    );

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
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Ingresa tu correo electrónico\n para iniciar sesion en la aplicación',
                    style: textInfoIniciar,
                  ),
                ),
                Form(
                   key: _formKey,
                  child: Column(
                    children: [
                      _CampoTexto(
                        validacion: (value) {
                          if (!FormUsuarios.validarEmail(value!)) {
                            return 'Correo invalido';
                          }
                          return null;
                        },
                        labelText: 'correoelectrónico@dominio.com',
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: (correoCorrecto & continuar) ? 67 : 0,
                        child: _CampoTexto(
                          validacion: (value) {},
                          labelText: 'Tu password',
                        ),
                      ),
                      BtnFormulario(
                        width: double.infinity,
                        text: 'Continuar',
                        func: () => (setState(() {
                          continuar = true;
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              correoCorrecto = true;
                            });
                          }
                        })),
                      ),
                    ],
                  ),
                ),
                _Division(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Eres nuevo? Registrate aqui !',
                    textAlign: TextAlign.center,
                    style: textIniciaSesion,
                  ),
                ),
                BtnFormulario(
                  width: double.infinity,
                  text: 'Registrarse', func: () => ()),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Al hacer clic en continuar, aceptas nuestros',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Inter'),
                  ),
                ),
                Text(
                  'Términos de servicio y Política de privacidad',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Inter', color: Color(0xFF1A00FF)),
                ),
              ],
            ),
          ),
        ),
      ),
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
    this.controller,
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
  const _Division({super.key});

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
