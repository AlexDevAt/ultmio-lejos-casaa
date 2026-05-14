import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/reserva.dart';
import 'package:lejos_de_casa_front/helpers/formatos/format_date.dart';
import 'package:lejos_de_casa_front/presentation/providers/reserva/provider_reserva.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/widgets/btn_form.dart';
import 'package:lejos_de_casa_front/presentation/widgets/icono_custom.dart';
import 'package:provider/provider.dart';

class ReservasScreen extends StatefulWidget {
  const ReservasScreen({super.key});
  static String name = 'reservas_screen';

  @override
  State<ReservasScreen> createState() => _ReservasScreenState();
}

class _ReservasScreenState extends State<ReservasScreen> {
  @override
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provUsuario = context.read<ProviderUsuarios>();
      final providerReserva = context.read<ProviderReserva>();

      final usuario = provUsuario.usuarioActual;

      if (usuario == null || usuario.curp == null) return;

      providerReserva.obtenerReservasUsuario(usuario.curp!);
    });
  }

  @override
  void dispose() {
    // final providerReserva = context.watch<ProviderReserva>();
    // providerReserva.limpiarReservas();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reservas',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
            ),
            Text('Reservas realizadas', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
      body: _ReservaView(),
    );
  }
}

class _ReservaView extends StatelessWidget {
  const _ReservaView({super.key});

  @override
  Widget build(BuildContext context) {
    final providerReserva = context.watch<ProviderReserva>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25),
        _BuscarReservas(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('Reservas recientes: ', style: TextStyle(fontSize: 20)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: providerReserva.reservas.length,
            itemBuilder: (context, index) {
              return _PreviewReserva(reserva: providerReserva.reservas[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _BuscarReservas extends StatelessWidget {
  const _BuscarReservas({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(),
              border: Border.all(width: 1.5),
            ),
            child: Row(
              children: [
                Icon(Icons.search_outlined),
                Text('Busca tus reservas aqui'),
                Spacer(),
                Container(width: 2, height: 60, color: Colors.black),
                SizedBox(width: 20),
                Expanded(child: Text('Filtar', style: TextStyle(fontSize: 20))),
                Icon(Icons.arrow_forward_ios_outlined),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PreviewReserva extends StatelessWidget {
  const _PreviewReserva({super.key, required this.reserva});
  final Reserva reserva;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 18),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black45.withValues(),
              blurRadius: 5,
              spreadRadius: .3,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _imagen(imageUrl: reserva.casa.imagen,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Container(
                    height: 100,
                    width: .6,
                    color: const Color.fromARGB(255, 134, 134, 134),
                  ),
                ),
                SizedBox(width: 2),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 5,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconoOpcion(
                              icon: Icon(
                                Icons.calendar_month_outlined,
                                size: 20,
                              ),
                              color: Color(0xFFDCEBFF),
                              sizeBorder: 7,
                              height: 27,
                              width: 27,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'ID Reserva : ${reserva.id}',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),

                        Row(
                          children: [
                            SizedBox(width: 2),
                            Icon(Icons.calendar_today_outlined, size: 15),
                            SizedBox(width: 10),
                            Text(
                              'Fechan inicio: : ${FormatDate.formatDate(reserva.fechaInicio)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),

                        Row(
                          children: [
                            SizedBox(width: 2),
                            Icon(Icons.calendar_today_outlined, size: 15),
                            SizedBox(width: 10),
                            Text(
                              'Fechan fin: : ${FormatDate.formatDate(reserva.fechaFin)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),

                        Row(
                          children: [
                            SizedBox(width: 2),
                            Icon(Icons.watch_later_outlined, size: 15),
                            SizedBox(width: 10),
                            Text(
                              'Estado: : ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              'Reservado',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: reserva.estado == 'Activo'
                                    ? Colors.green
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 4,
              right: 6,
              child: TextButton(
                // label: Text('Ver mas', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                onPressed: () => (),
                style: TextButton.styleFrom(
                  minimumSize: Size(0, 0),
                  padding: EdgeInsets.symmetric(horizontal: 11, vertical: 8),

                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(9),
                  ),
                  backgroundColor: Color(0xFF0b1636),
                ),
                child: Row(
                  children: [
                    Text(
                      'Ver mas',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _imagen extends StatelessWidget {
  const _imagen({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(10),
        child: Image.asset(
          fit: BoxFit.cover,
          height: 100,
          width: 170,

          'assets/images/casas/$imageUrl',
        ),
      ),
    );
  }
}
