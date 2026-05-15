import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/domain/entities/propietario.dart';
import 'package:lejos_de_casa_front/helpers/formatos/format_date.dart';
import 'package:lejos_de_casa_front/presentation/providers/resenia/provider_resenia.dart';
import 'package:lejos_de_casa_front/presentation/widgets/btn_form.dart';
import 'package:lejos_de_casa_front/presentation/widgets/foto_perfil.dart';
import 'package:lejos_de_casa_front/presentation/widgets/icono_custom.dart';
import 'package:lejos_de_casa_front/presentation/widgets/resenia_widget.dart';
import 'package:provider/provider.dart';

class InfoCasa extends StatefulWidget {
  const InfoCasa({super.key, required this.casa});
  static const String name = 'InfoCasa_screen.';
  final Casa casa;

  @override
  State<InfoCasa> createState() => _InfoCasaState();
}

class _InfoCasaState extends State<InfoCasa> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final ProviderResenia providerResenia = context.read<ProviderResenia>();
      providerResenia.limpiarTodasResenias();
      if (!providerResenia.isLoading) return;
      providerResenia.obtenerReseniasCasa(widget.casa.id);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.favorite_border_outlined, size: 30),
          SizedBox(width: 16),
          Icon(Icons.share_outlined, size: 30),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            _image(),
            _viewInfo(casa: widget.casa),
          ],
        ),
      ),
    );
  }
}

class _viewInfo extends StatelessWidget {
  const _viewInfo({required this.casa});
  final Casa casa;

  @override
  Widget build(BuildContext context) {
    final ProviderResenia providerResenia = context.watch<ProviderResenia>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ubicacion de la casa',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
          ),
          ButtonUbicacion(),
          SizedBox(height: 20),
          _PrecioBox(precio: casa.precio),
          SizedBox(height: 30),
          _labelSeparador(texto: 'Detalles de la propiedad'),
          SizedBox(height: 20),

          DetalleDataIconVerticalLabel(
            icon: Icons.door_front_door_outlined,
            title: 'Numero interior',
            data: casa.numInterior.toString(),
          ),
          SizedBox(height: 30),
          DetalleDataIconVerticalLabel(
            icon: Icons.settings_ethernet_rounded,
            title: 'Calle',
            data: casa.calle,
          ),
          SizedBox(height: 30),
          DetalleDataIconVerticalLabel(
            icon: Icons.map_outlined,
            title: 'Ciudad',
            data: casa.region.estado,
          ),
          SizedBox(height: 30),
          DetalleDataIconVerticalLabel(
            icon: Icons.location_city_outlined,
            title: 'Municipio',
            data: casa.region.municipio,
          ),
          SizedBox(height: 30),
          DetalleDataIconVerticalLabel(
            icon: Icons.numbers_outlined,
            title: 'Codigo postal',
            data: casa.region.municipio,
          ),
          SizedBox(height: 30),
          DetalleDataIconVerticalLabel(
            icon: Icons.format_list_numbered_sharp,
            title: 'Cupo',
            data: casa.cupo.toString(),
          ),
          SizedBox(height: 30),
          DetalleDataIconVerticalLabel(
            icon: Icons.check_circle_outlined,
            title: 'Estado',
            data: 'Disponible',
          ),
          SizedBox(height: 30),
          _labelSeparador(texto: 'Mapa de la zona'),
          SizedBox(height: 20),
          _MapaUbi(),
          SizedBox(height: 30),
          Center(child: PropietarioCasa(propietario: casa.propietario)),
          SizedBox(height: 30),
          Center(
            child: BtnFormulario(
              horizontal: 40,
              text: 'Solicitar reserva',
              func: () => (),
              width: 50,
              height: 50,
              color: Color.fromARGB(255, 59, 116, 190),
            ),
          ),
          SizedBox(height: 30),
          _labelSeparador(texto: 'Reseñas'),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: providerResenia.reseniasActualesCasa.length,
            itemBuilder: (context, index) {
              return ReseniaWidget(
                resenia: providerResenia.reseniasActualesCasa[index],
                size: MediaQuery.of(context).size,
                color: Color.fromRGBO(238, 242, 250, 1),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PrecioBox extends StatelessWidget {
  const _PrecioBox({super.key, required this.precio});
  final double precio;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200.withValues(),
            blurRadius: 3,
            spreadRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Precio: ', style: TextStyle(fontSize: 20)),
            Text('\$$precio', style: TextStyle(fontSize: 40)),
            Text(' mensual ', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

class _labelSeparador extends StatelessWidget {
  final String texto;

  const _labelSeparador({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 4.5,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 59, 116, 190),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(width: 10),
        Text(
          texto,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class ButtonUbicacion extends StatelessWidget {
  const ButtonUbicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromARGB(95, 187, 187, 187),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(9),
        ),
      ),

      icon: Icon(Icons.location_on_outlined, color: Colors.black54),
      onPressed: () => (),
      label: Text(
        'Ubicacion exacta',
        style: TextStyle(
          fontSize: 15.5,
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _image extends StatelessWidget {
  const _image({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      child: Image.asset(
        width: double.maxFinite,
        height: size.height * .35,
        fit: BoxFit.cover,
        'assets/images/casas/img1.jpg',
      ),
    );
  }
}

class DetalleDataIconVerticalLabel extends StatelessWidget {
  const DetalleDataIconVerticalLabel({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
  });
  final IconData icon;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300.withValues(),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
          color: Color.fromRGBO(238, 242, 250, 1),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          children: [
            IconoOpcion(
              icon: Icon(icon, color: Colors.white, size: 40),
              color: Color.fromARGB(255, 59, 116, 190),
              sizeBorder: 9,
              height: 60,
              width: 60,
            ),
            SizedBox(width: 15),
            Text(
              '$title : ',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  data,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PropietarioCasa extends StatelessWidget {
  const PropietarioCasa({super.key, required this.propietario});
  final Propietario propietario;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(238, 242, 250, 1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black45.withValues(),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              'Propietario',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            FotoPerfil(color: Colors.grey.shade400),
            SizedBox(height: 20),
            Text(
              propietario.nombres + propietario.apellidos,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Miembro desde ${FormatDate.formatDate(propietario.fechaRegistro!)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            BtnFormulario(
              text: 'Mas informacion',
              func: () => context.push('/propietarioInfo', extra: propietario),
              width: size.width * .50,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class _MapaUbi extends StatelessWidget {
  const _MapaUbi({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(8),
      child: Image.asset(
        height: size.height * .30,
        fit: BoxFit.cover,
        'assets/images/mapa/mapa_ejemplo.png',
      ),
    );
  }
}
