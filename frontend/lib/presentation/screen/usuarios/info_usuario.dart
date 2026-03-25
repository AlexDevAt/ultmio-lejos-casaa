import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/usuario.dart';
import 'package:lejos_de_casa_front/helpers/advertenciaBorrar.dart';
import 'package:lejos_de_casa_front/helpers/editar_campo.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/widgets/btn_custom.dart';
import 'package:provider/provider.dart';

class InfoUsuario extends StatelessWidget {
  const InfoUsuario({super.key, required this.usuario});
  static String name = 'info_suario';
  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(height: 340, color: color.primary),
        Positioned(
          top: 240,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [_InfoLista(usuario: usuario)],
            ),
          ),
        ),

        Positioned(
          bottom: size.height / 2 + 50,
          right: size.width / 2 - 100,
          child: CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage(
              'assets/images/usuarios/icono_usuario.png',
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoLista extends StatelessWidget {
  const _InfoLista({required this.usuario});

  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        CampoTexto(
          title: 'Nombres',
          sub: usuario.nombres,
          campoApi: 'nombres',
          curp: usuario.curp,
        ),
        CampoTexto(
          title: 'Apellidos',
          curp: usuario.curp,
          sub: usuario.apellidos,
          campoApi: 'apellidos',
        ),
        CampoTexto(
          title: 'Correo',
          sub: usuario.correo,
          campoApi: 'correos',
          curp: usuario.curp,
        ),
        CampoTexto(
          title: 'Telefono',
          sub: usuario.telefono,
          campoApi: 'telefono',
          curp: usuario.curp,
        ),
        CampoTexto(
          title: 'Calle',
          sub: usuario.calle,
          campoApi: 'calle',
          curp: usuario.curp,
        ),
        CampoTexto(
          title: 'Numero interior',
          sub: usuario.numeroInterior.toString(),
          campoApi: 'num_interior',
          curp: usuario.curp,
        ),
        CampoTexto(
          title: 'Municipio',
          sub: usuario.municipio,
          campoApi: 'muninipio',
          curp: usuario.curp,
        ),
        CampoTexto(
          title: 'Ciudad',
          sub: usuario.ciudad,
          campoApi: 'ciudad',
          curp: usuario.curp,
        ),
        CampoTexto(
          title: 'Codigo postal',
          sub: usuario.codigoPostal,
          campoApi: 'codigo_postal',
          curp: usuario.curp,
        ),
        CampoTexto(
          title: ' Curp',
          sub: usuario.curp,
          campoApi: 'curp',
          curp: usuario.curp,
        ),
        Center(
          child: BtnCustom(
            texto: 'Borrar',
            color: Colors.red,
            ontap: () async {
              final curpBorrar = await dialogBorrarUsuario(
                context: context,
                curp: usuario.curp,
              );
              context.read<ProviderUsuarios>().borrarUsuario(usuario.curp);

              
            },
          ),
        ),
      ],
    );
  }
}

class CampoTexto extends StatelessWidget {
  const CampoTexto({
    super.key,
    required this.title,
    required this.sub,
    required this.campoApi,
    required this.curp,
  });

  final String title;
  final String sub;
  final String curp;
  final String campoApi;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(sub, style: TextStyle(fontWeight: FontWeight.w400)),

          trailing: IconButton(
            onPressed: () async {
              final nuevo = await dialogEditarCampo(
                context: context,
                titulo: title,
                valorInicial: sub,
              );

              if (nuevo == null || nuevo == sub) return;
              context.read<ProviderUsuarios>().actualizarUsuario(curp, {
                campoApi: nuevo,
              });
            },
            icon: Icon(Icons.edit),
          ),
        ),
        Divider(thickness: 1, color: Colors.black),
      ],
    );
  }
}
