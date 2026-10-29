import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/domain/entities/reserva.dart';
import 'package:lejos_de_casa_front/helpers/formatos/format_date.dart';
import 'package:lejos_de_casa_front/presentation/providers/reserva/provider_reserva.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/widgets/btn_form.dart';
import 'package:lejos_de_casa_front/presentation/widgets/icono_custom.dart';
import 'package:provider/provider.dart';

import 'package:dio/dio.dart';


class PropiedadesScreen extends StatelessWidget {
  const PropiedadesScreen({super.key});
  static String name = 'propiedades_screen';


  @override
  Widget build(BuildContext context) {
    print(context.watch<ProviderUsuarios>().usuarioActual!.casasVenta!.length);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => context.push('/registrar_casa'),
            icon: Icon(Icons.add, size: 30),
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Propiedades',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
            ),
            Text(
              'Casasa en tu propiedad en arrendamiento',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      body: _ReservaView(),
    );
  }
}

class _ReservaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProviderUsuarios providerUsuarios = context.watch<ProviderUsuarios>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25),
        _BuscarReservas(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('Propiedades ', style: TextStyle(fontSize: 20)),
        ),
        Expanded(
          child:
              (!providerUsuarios.isLoading ||
                  providerUsuarios.usuarioActual!.casasVenta!.isNotEmpty)
              ? ListView.builder(
                  itemCount: providerUsuarios.usuarioActual?.casasVenta!.length,
                  itemBuilder: (context, index) {
                    return _PreviewReserva(
                      propiedad:
                          providerUsuarios.usuarioActual!.casasVenta![index],
                    );
                  },
                )
              : Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
      ],
    );
  }
}

class _BuscarReservas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(),
              border: Border.all(width: 1, color: Colors.black45),
            ),
            child: Row(
              children: [
                Icon(Icons.search_outlined),
                Text('Busca tus reservas aqui'),
                Spacer(),
                Container(width: 2, height: 60, color: Colors.black45),
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
  const _PreviewReserva({required this.propiedad});
  final Casa propiedad;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black45.withValues(),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _imagen(imageUrl: propiedad.imagen),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Container(width: 1, color: Colors.grey.shade300),
                  ),
                  SizedBox(width: 2),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 5,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                              Expanded(
                                child: Text(
                                  'ID Propiedad : ${propiedad.id}',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          Row(
                            children: [
                              SizedBox(width: 2),
                              Icon(Icons.calendar_today_outlined, size: 15),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  '${propiedad.titulo}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),

                          Row(
                            children: [
                              SizedBox(width: 2),
                              Icon(Icons.calendar_today_outlined, size: 15),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  propiedad.region?.estado ?? '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),

                          Row(
                            children: [
                              SizedBox(width: 2),
                              Icon(Icons.watch_later_outlined, size: 15),
                              SizedBox(width: 10),
                              Text(
                                'Precio : ${propiedad.precio}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              // Text(
                              //   'Estado: : ',
                              //   style: TextStyle(
                              //     fontSize: 12,
                              //     color: Colors.black54,
                              //   ),
                              // ),
                              // Text(
                              //   'Reservado',
                              //   style: TextStyle(
                              //     fontSize: 12,
                              //     fontWeight: FontWeight.bold,
                              //     // color: propiedad.estado == 'Activo'
                              //     //     ? Colors.green
                              //     //     : Colors.black54,
                              //   ),
                              // ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: _buttonDetalles(casa: propiedad)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buttonDetalles extends StatelessWidget {
  final Casa casa;

  const _buttonDetalles({super.key, required this.casa});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: TextButton.icon(
        // label: Text('Ver mas', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        onPressed: () => context.push('/detallePropiedad', extra: casa),
        style: TextButton.styleFrom(
          minimumSize: Size(0, 0),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(9),
          ),
          backgroundColor: Color(0xFF0b1636),
        ),
        label: Text(
          'Detalles',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(10),
        child: Image.asset(
          fit: BoxFit.cover,
          height: 140,
          width: 170,

          'assets/images/casas/$imageUrl',
        ),
      ),
    );
  }
}
