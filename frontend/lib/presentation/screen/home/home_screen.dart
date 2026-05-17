import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/domain/entities/usuario.dart';
import 'package:lejos_de_casa_front/presentation/providers/casa/provider_casas.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/widgets/barrra_busqueda.dart';
import 'package:lejos_de_casa_front/presentation/widgets/card_filtro.dart';
import 'package:lejos_de_casa_front/presentation/widgets/imagen_casa.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String name = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final ProviderUsuarios usuarioActual = context.watch<ProviderUsuarios>();
    final ProviderCasas providerCasas = context.watch<ProviderCasas>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: false,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LEJOS DE CASA',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF144956),
                  ),
                ),
                Text(
                  'Aplicacion de renta de casas',
                  style: TextStyle(
                    wordSpacing: -1,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF144956),
                  ),
                ),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: _homeView(
              usuario: usuarioActual.usuarioActual!,
              casaProvider: providerCasas,
            ),
          ),
        ],
      ),
    );
  }
}

class _homeView extends StatelessWidget {
  final Usuario usuario;
  final ProviderCasas casaProvider;

  const _homeView({required this.usuario, required this.casaProvider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '👋 Hola ${usuario.nombres}!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.4),
              ),
              Spacer(),
              IconButton(
                onPressed: () => (),
                icon: Icon(Icons.notifications_outlined, size: 30),
              ),
              IconButton(
                onPressed: () => (),
                icon: Icon(Icons.person_outline_outlined, size: 30),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '📍${usuario.ciudad}, ${usuario.municipio}.',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(height: 13),
          BarraBusqueda(
            validacion: (value) => '',
            controller: TextEditingController(),
            onPress: () => (),
            text: 'Busca por univerdidad, ciudad o colonia',
            colorBackGround: Color(0xFFF5EFF7),
            padingHor: 0,
            colorBorder: Colors.black,
            borderSize: 30,
            prefixIcon: true,
            iconSize: 30,
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CardFiltro(textoSup: 'Cerca de', textoinF: 'Universidades🎓'),
                SizedBox(width: 8),
                CardFiltro(
                  textoSup: 'Economicas',
                  textoinF: '(Mejor precio)🔖',
                ),
                SizedBox(width: 8),
                CardFiltro(textoSup: 'Mejor', textoinF: 'Calificadas ⭐'),
                SizedBox(width: 8),
                CardFiltro(textoSup: 'Casas', textoinF: 'Completas 🏠'),
              ],
            ),
          ),
          TipoDeCasasVerMas(tipo: 'Lo mas popular', func: () => ()),
          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: false,
              itemCount: casaProvider.casasHome1.length,
              itemBuilder: (context, index) {
                return Row(children: [CardCasa(casa: casaProvider.casasHome1[index],), SizedBox(width: 12)]);
              },
            ),
          ),
          SizedBox(height: 20),
          TipoDeCasasVerMas(tipo: 'Recien agregadas', func: () => ()),
          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: false,
              itemCount: casaProvider.casasHome2.length,
              itemBuilder: (context, index) {
                return Row(children: [CardCasa(casa: casaProvider.casasHome2[index],), SizedBox(width: 12)]);
              },
            ),
          ),
          SizedBox(height: 20),
          TipoDeCasasVerMas(tipo: 'Explora cerca de ti', func: () => ()),
          Padding(
            padding: const EdgeInsets.only(top: 55),
            child: Image.asset(
              'assets/images/mapa/mapa_ejemplo.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

class TipoDeCasasVerMas extends StatelessWidget {
  const TipoDeCasasVerMas({super.key, required this.tipo, required this.func});

  final String tipo;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(tipo, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        Spacer(),
        TextButton(
          onPressed: func,
          child: Text(
            'Ver mas > ',
            style: TextStyle(fontSize: 15, color: Color(0xFF0088FF)),
          ),
        ),
      ],
    );
  }
}



class CardCasa extends StatelessWidget {
  const CardCasa({super.key, required this.casa});
  final Casa casa;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ImageForCardCasa(
                    maxHeight: constraints.maxHeight,
                    maxWidth: constraints.maxWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        Icon(Icons.star, color: Colors.grey.shade400, size: 18),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            '${casa.region!.estado},${casa.region!.municipio}',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Precio: '),
                          TextSpan(
                            text: '\$${casa.precio}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(text: '/m'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 15,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.wifi_outlined),
                        Icon(Icons.water_drop_outlined),
                        Icon(Icons.electric_bolt_outlined),
                        Icon(Icons.shield_moon_outlined),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(bottom: 0, right: 0, child: _buttonDetalles()),
            ],
          );
        },
      ),
    );
  }
}

class _ImageForCardCasa extends StatelessWidget {
  const _ImageForCardCasa({
    super.key,
    required this.maxWidth,
    required this.maxHeight,
  });
  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.directional(
        topStart: Radius.circular(30),
        topEnd: Radius.circular(30),
      ),
      child: Image.asset(
        width: maxWidth,
        fit: BoxFit.cover,
        height: maxHeight * .60,
        'assets/images/casas/img1.jpg',
      ),
    );
  }
}

class _buttonDetalles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        // label: Text('Ver mas', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        onPressed: () => (),
        style: TextButton.styleFrom(
          minimumSize: Size(0, 0),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(9),
          ),
          backgroundColor: Color(0xFF0b1636),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Detalles',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
