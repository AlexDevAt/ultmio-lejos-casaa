import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/reserva.dart';
import 'package:lejos_de_casa_front/presentation/providers/reserva/provider_reserva.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
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
              return _CardReserva(reserva: providerReserva.reservas[index]);
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

class _CardReserva extends StatelessWidget {
  const _CardReserva({super.key, required this.reserva});
  final Reserva reserva;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // IMAGEN
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    'assets/images/casas/${reserva.casa.imagen}',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 14),

                // LINEA
                Container(width: 1, color: Colors.black12),

                const SizedBox(width: 14),

                // INFO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      // ID
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 18,
                            color: Colors.blueGrey,
                          ),

                          const SizedBox(width: 6),

                          Expanded(
                            child: Text(
                              'ID reserva: ${reserva.id}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Fecha inicio: ${reserva.fechaInicio.toString()}',
                        style: TextStyle(fontSize: 14),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Fecha fin:  ${reserva.fechaFin.toString()}',
                        style: TextStyle(fontSize: 14),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Text('Estado:', style: TextStyle(fontSize: 14)),

                          const SizedBox(width: 5),

                          Flexible(
                            child: Text(
                              reserva.estado,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          height: 38,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Ver más',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
