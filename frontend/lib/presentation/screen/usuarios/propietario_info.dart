import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/propietario.dart';
import 'package:lejos_de_casa_front/domain/entities/resenia.dart';
import 'package:lejos_de_casa_front/presentation/providers/resenia/provider_resenia.dart';
import 'package:lejos_de_casa_front/presentation/widgets/foto_perfil.dart';
import 'package:lejos_de_casa_front/presentation/widgets/icono_custom.dart';
import 'package:lejos_de_casa_front/presentation/widgets/resenia_card.dart';
import 'package:provider/provider.dart';

class PropietarioInfo extends StatefulWidget {
  const PropietarioInfo({super.key, required this.propietario});
  static String name = 'propietario_info';
  final Propietario propietario;

  @override
  State<PropietarioInfo> createState() => _PropietarioInfoState();
}

class _PropietarioInfoState extends State<PropietarioInfo> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final ProviderResenia providerResenia = context.read<ProviderResenia>();
      providerResenia.isLoading = true;
      if (!providerResenia.isLoading) return;
      providerResenia.obtenerReseniasUsuario(widget.propietario.curp);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProviderResenia providerResenia = context.watch<ProviderResenia>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Propietario',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Center(
                child: FotoPerfil(
                  color: Colors.yellow.shade50,
                  height: 150,
                  width: 150,
                  sizeIcon: 140,
                ),
              ),
              SizedBox(height: 10),
              BoxDatos(propietario: widget.propietario),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Reseñas'),
                  Spacer(),
                  TextButton(onPressed: () => (), child: Text('Ver mas')),
                ],
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: providerResenia.reseniasActualesUsuarios
                      .take(3)
                      .toList()
                      .length,
                  itemBuilder: (context, index) {
                    return ReseniaCard(
                      size: MediaQuery.of(context).size.width * .32,
                      color: Colors.white,
                      resenia: providerResenia.reseniasActualesUsuarios[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxDatos extends StatelessWidget {
  const BoxDatos({super.key, required this.propietario});
  final Propietario propietario;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Color.fromRGBO(238, 242, 250, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          CampoDato(
            dato: propietario.nombres,
            titulo: 'Nombre(s)',
            icon: Icon(Icons.person_outline_outlined),
          ),
          CampoDato(
            dato: propietario.apellidos,
            titulo: 'Nombre(s)',
            icon: Icon(Icons.person_outline_outlined),
          ),
          CampoDato(
            dato: propietario.apellidos,
            titulo: 'Nombre(s)',
            icon: Icon(Icons.person_outline_outlined),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class CampoDato extends StatelessWidget {
  const CampoDato({
    super.key,
    required this.titulo,
    required this.dato,
    required this.icon,
  });

  final String titulo;
  final String dato;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo),
          SizedBox(height: 10),
          BoxInfoDato(dato: dato, icon: icon),
        ],
      ),
    );
  }
}

class BoxInfoDato extends StatelessWidget {
  const BoxInfoDato({super.key, required this.dato, required this.icon});
  final String dato;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            IconoOpcion(
              icon: icon,
              color: Color(0xFFDCEBFF),
              sizeBorder: 20,
              height: 38,
              width: 38,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(dato, style: TextStyle(fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}
