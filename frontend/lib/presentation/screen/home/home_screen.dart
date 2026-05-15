import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/domain/entities/filtro.dart';
import 'package:lejos_de_casa_front/presentation/providers/casa/provider_casas.dart';
import 'package:lejos_de_casa_front/presentation/widgets/btn_form.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String name = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final controllerCodigoP = TextEditingController();
  @override
  void dispose() {
    controllerCodigoP.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      final providerCasa = context.read<ProviderCasas>();
      if (!providerCasa.casasCargadosPrimera) {
        providerCasa.obtenerCasas();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerCasa = context.watch<ProviderCasas>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Form(
            key: _formKey,
            child: _BarraBusqueda(
              onPress: () {
                if (_formKey.currentState!.validate()) {
                  providerCasa.obtenerCasas(
                    filtro: controllerCodigoP.value.text,
                    tipoFiltro: 'codigo_postal',
                  );
                }
              },
              controller: controllerCodigoP,
              validacion: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un codigo posta valido';
                }
                return null;
              },
            ),
          ),
        ),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  _BarraFiltros(
                    filtrosMenu: [
                      Filtro(
                        titulo: 'Tipo de casa',
                        opciones: ['Una planta', 'Dos plantas', 'Otro tipo'],
                      ),
                      Filtro(
                        titulo: 'Cantidad de cuartos',
                        opciones: ['1', '2', '3', '+4'],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      providerCasa.obtenerCasas();
                      providerCasa.filtroActivo = false;
                    },
                    child: AnimatedOpacity(
                      duration: Duration(microseconds: 300),
                      opacity: (providerCasa.filtroActivo) ? 1 : 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: (!providerCasa.filtroActivo) ? 0 : 10,
                          vertical: 15,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: BoxBorder.all(
                            color: Colors.grey.shade400,
                            strokeAlign: 4,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Limpiar',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // _BarraFiltros(),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text('${providerCasa.casas.length} resulados'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Image.asset(
                'assets/images/mapa/mapa_ejemplo.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: providerCasa.casas.length,
            itemBuilder: (context, index) {
              Casa casa = providerCasa.casas[index];
              return Center(child: CardCasa(casa: casa));
            },
          ),
        ),
      ],
    );
  }
}

class _BarraBusqueda extends StatelessWidget {
  final FormFieldValidator<String> validacion;
  final TextEditingController controller;
  final VoidCallback onPress;
  const _BarraBusqueda({
    required this.validacion,
    required this.controller,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        controller: controller,
        validator: validacion,
        decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: onPress, icon: Icon(Icons.search)),
          filled: true,
          hintText: 'Ingresa un codigo postal',
          fillColor: Colors.grey.shade300,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}

class _BarraFiltros extends StatelessWidget {
  final List<Filtro> filtrosMenu;

  const _BarraFiltros({required this.filtrosMenu});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(alignment: AlignmentGeometry.bottomStart),
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () => controller.open(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: BoxBorder.all(
                color: Colors.grey.shade400,
                strokeAlign: 4,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Filtrar',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
      menuChildren: filtrosMenu.map((e) {
        return FiltroBusqueda(filtro: e, contextOrig: context);
      }).toList(),
    );
  }
}

class FiltroBusqueda extends StatelessWidget {
  const FiltroBusqueda({
    super.key,
    required this.filtro,
    required this.contextOrig,
  });
  final BuildContext contextOrig;

  final Filtro filtro;

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: () {
        showDialog<String>(
          context: contextOrig,
          builder: (context) {
            return AlertDialog(
              title: Center(child: Text(filtro.titulo)),
              actions: [
                Center(
                  child: Column(
                    children: filtro.opciones.map((e) {
                      return FilterChip(
                        label: Text(e),
                        onSelected: (value) {
                          Navigator.pop(context);
                          context.read<ProviderCasas>().obtenerCasas(
                            filtro: e.trim(),
                            tipoFiltro: filtro.titulo.toLowerCase()
                          );
                         
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Text(filtro.titulo),
    );
  }
}

class _ImagenCasa extends StatelessWidget {
  const _ImagenCasa({super.key, required this.imageUrl});
  final imageUrl;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Container(
        width: size.width * .85,
        height: size.height * .20,
        child: ClipRRect(child: Image.asset('assets/images/casas/$imageUrl')),
      ),
    );
  }
}

class CardCasa extends StatelessWidget {
  const CardCasa({super.key, required this.casa});
  final Casa casa;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ImagenCasa(imageUrl: casa.imagen),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      casa.titulo,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.grey.shade400),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '\$${casa.precio}',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                  Text('Mensual'),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Center(child: Text(casa.calle)),
          SizedBox(height: 10),
          Center(
            child: BtnFormulario(
              height: MediaQuery.of(context).size.height * .05,
              text: 'Seleccionar',
              func: () => (),
              width: 160,
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
