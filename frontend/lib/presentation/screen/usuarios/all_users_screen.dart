import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lejos_de_casa_front/domain/entities/usuario.dart';
import 'package:lejos_de_casa_front/helpers/assets_rutas.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/widgets/btn_general.dart';
import 'package:provider/provider.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});
  static String name = 'all_user_screen';

  @override
  Widget build(BuildContext context) {
    final provUsuario = context.watch<ProviderUsuarios>();
    Future.microtask(() {
      if (!provUsuario.usuariosCargadosPrimera) {
        context.read<ProviderUsuarios>().obtenerUsuarios();
      }
    });
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: provUsuario.usuarios.length,
      itemBuilder: (context, index) {
        Usuario usuario = provUsuario.usuarios[index];
        return _CajaDeUsuario(usuario: usuario);
      },
    );
  }
}

class _CajaDeUsuario extends StatelessWidget {
  final Usuario usuario;
  const _CajaDeUsuario({required this.usuario});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(border: BoxBorder.all()),
          height: 150,
          width: size.width,
          child: Row(
            children: [
              _IconImage(),
              SizedBox(width: 20),
              Container(
                width: 200,
                height: 200,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${usuario.nombres}  ${usuario.apellidos}',
                      maxLines: 2,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),

              SizedBox(width: (size.width * .010)),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BtnGeneral(
                  onPressed: () {
                    context.push('/usuarios/infoUsuario', extra: usuario);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage('assets/images/usuarios/icono_usuario.png'),
    );
  }
}
