import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';
import 'package:lejos_de_casa_front/presentation/providers/casa/provider_casas.dart';
import 'package:lejos_de_casa_front/presentation/providers/usuarios/provider_usuarios.dart';
import 'package:lejos_de_casa_front/presentation/widgets/btn_form.dart';
import 'package:lejos_de_casa_front/presentation/widgets/mapa_ubi.dart';
import 'package:provider/provider.dart';

List<String> estadosMexico = [
  'AGUASCALIENTES',
  'BAJA CALIFORNIA',
  'BAJA CALIFORNIA SUR',
  'CAMPECHE',
  'CHIAPAS',
  'CHIHUAHUA',
  'COAHUILA',
  'COLIMA',
  'CIUDAD DE MEXICO',
  'DURANGO',
  'ESTADO DE MEXICO',
  'GUANAJUATO',
  'GUERRERO',
  'HIDALGO',
  'JALISCO',
  'MICHOACAN',
  'MORELOS',
  'NAYARIT',
  'NUEVO LEON',
  'OAXACA',
  'PUEBLA',
  'QUERETARO',
  'QUINTANA ROO',
  'SAN LUIS POTOSI',
  'SINALOA',
  'SONORA',
  'TABASCO',
  'TAMAULIPAS',
  'TLAXCALA',
  'VERACRUZ',
  'YUCATAN',
  'ZACATECAS',
];

final boxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(20),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.shade300,
      blurRadius: 2,
      spreadRadius: 1,
      offset: const Offset(0, 1),
    ),
  ],
);

class CrearCasa extends StatefulWidget {
  const CrearCasa({super.key});
  static String name = 'registrar_casa';

  @override
  State<CrearCasa> createState() => _CrearCasaState();
}

class _CrearCasaState extends State<CrearCasa> {
  // Llave global del Formulario
  final _formKey = GlobalKey<FormState>();

  // Controladores de Texto para las secciones del formulario
  final TextEditingController _tituloCtrl = TextEditingController();
  final TextEditingController _precioCtrl = TextEditingController();
  final TextEditingController _calleCtrl = TextEditingController();
  final TextEditingController _numInteriorCtrl = TextEditingController();
  final TextEditingController _cpCtrl = TextEditingController();

  // Variables de Estado para los selectores
  String? _estadoSeleccionado;
  String? _tipoCasaSeleccionado;
  int _cupoMaximo = 0;
  int _cantidadCuartos = 0;
  String? _imgUrl;

  @override
  void dispose() {
    // Liberación estricta de memoria para todos los controladores
    _tituloCtrl.dispose();
    _precioCtrl.dispose();
    _calleCtrl.dispose();
    _numInteriorCtrl.dispose();
    _cpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProviderUsuarios providerUsuarios = context.watch<ProviderUsuarios>();
    final ProviderCasas providerCasas = context.watch<ProviderCasas>();

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Registrar casa'),
            Text(
              'Completa la informacion de la casa',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 18),

                // 1. Tarjeta de Fotografía
                CardFotoCasa(
                  imageUrl: _imgUrl,
                  onImageChanged: (newPath) {
                    setState(() {
                      _imgUrl = newPath;
                    });
                  },
                ),
                const SizedBox(height: 15),

                // 2. Sección de Información General (Contiene Título, Precio y Atributos)
                TipoDeInfo(tipo: 'Informacion general', func: () {}),
                const SizedBox(height: 15),
                CardInfoGeneral(
                  tituloCtrl: _tituloCtrl,
                  precioCtrl: _precioCtrl,
                  tipoCasaSeleccionado: _tipoCasaSeleccionado,
                  onTipoCasaChanged: (value) {
                    setState(() {
                      _tipoCasaSeleccionado = value;
                    });
                  },
                  cupo: _cupoMaximo,
                  onCupoChanged: (value) {
                    setState(() {
                      _cupoMaximo = value;
                    });
                  },
                  cuartos: _cantidadCuartos,
                  onCuartosChanged: (value) {
                    setState(() {
                      _cantidadCuartos = value;
                    });
                  },
                ),
                const SizedBox(height: 15),

                // 3. Sección de Ubicación
                TipoDeInfo(tipo: 'Ubicacion', func: () {}),
                const SizedBox(height: 15),
                CardUbicacion(
                  calleCtrl: _calleCtrl,
                  numInteriorCtrl: _numInteriorCtrl,
                  cpCtrl: _cpCtrl,
                  estadoSeleccionado: _estadoSeleccionado,
                  onEstadoChanged: (value) {
                    setState(() {
                      _estadoSeleccionado = value;
                    });
                  },
                ),
                const SizedBox(height: 15),

                // 4. Botón de Envío y mapeo a la Entidad
                BtnFormulario(
                  text: 'Crear casa',
                  width: double.infinity,
                  height: 50,
                  func: () async {
                    if (_formKey.currentState!.validate() &&
                        _imgUrl != null &&
                        _tipoCasaSeleccionado != null) {
                      // Instanciación del modelo con datos validados y transformados
                      Casa casa = Casa(
                        id: -1,
                        cupo: _cupoMaximo,
                        tipo: _tipoCasaSeleccionado!,
                        imagen: _imgUrl!,
                        cuartos: _cantidadCuartos,
                        calle: _calleCtrl.text,
                        numInterior: int.parse(_numInteriorCtrl.text),
                        precio: double.parse(_precioCtrl.text),
                        titulo: _tituloCtrl.text,
                        idRegion: _cpCtrl.text,
                        idPropietario: providerUsuarios.usuarioActual!.curp,
                      );
                      await providerCasas.crearCasa(casa);
                      context.read<ProviderUsuarios>().usuarioActual!.casasVenta!.add(casa);
                      if (context.mounted) {
                        if (providerCasas.error == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Casa creada con exito!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              backgroundColor: Colors.green.shade200,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                providerCasas.error!,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.red.shade400,
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TipoDeInfo extends StatelessWidget {
  const TipoDeInfo({super.key, required this.tipo, required this.func});
  final String tipo;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.edit_document,
          color: Colors.lightBlueAccent.shade200,
          size: 22,
        ),
        const SizedBox(width: 10),
        Text(
          tipo,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ],
    );
  }
}

class CardFotoCasa extends StatelessWidget {
  const CardFotoCasa({super.key, this.imageUrl, required this.onImageChanged});
  final String? imageUrl;
  final ValueChanged<String> onImageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: boxDecoration,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            child: _BoxImage(imageUrl: imageUrl),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Foto de la casa',
                    style: TextStyle(
                      color: Color.fromARGB(255, 17, 34, 85),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'Sube una fotografía de la fachada principal',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _buttonDetalles(
                    voidCallback: () {
                      final random = Random();
                      int randomNumber = random.nextInt(6) + 1;
                      onImageChanged('img$randomNumber.jpg');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BoxImage extends StatelessWidget {
  const _BoxImage({this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: imageUrl == null
          ? const Icon(Icons.home_outlined, size: 50, color: Colors.black38)
          : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/casas/$imageUrl',
                fit: BoxFit.cover,
                height: 100,
                width: 120,
              ),
            ),
    );
  }
}

class _buttonDetalles extends StatelessWidget {
  const _buttonDetalles({required this.voidCallback});
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: TextButton.icon(
        onPressed: voidCallback,
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          backgroundColor: const Color(0xFF0b1636),
        ),
        label: const Text(
          'Subir imagen',
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

class CardInfoGeneral extends StatelessWidget {
  const CardInfoGeneral({
    super.key,
    required this.tituloCtrl,
    required this.precioCtrl,
    required this.tipoCasaSeleccionado,
    required this.onTipoCasaChanged,
    required this.cupo,
    required this.onCupoChanged,
    required this.cuartos,
    required this.onCuartosChanged,
  });

  final TextEditingController tituloCtrl;
  final TextEditingController precioCtrl;
  final String? tipoCasaSeleccionado;
  final ValueChanged<String?> onTipoCasaChanged;
  final int cupo;
  final ValueChanged<int> onCupoChanged;
  final int cuartos;
  final ValueChanged<int> onCuartosChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // Inyección de controladores heredados del padre
          CardOption(
            hintText: 'Ej. Hermosa casa...',
            title: 'Titulo',
            horizontalPad: 0,
            controller: tituloCtrl,
          ),
          CardOption(
            hintText: 'Ej. 2500',
            title: 'Precio',
            horizontalPad: 0,
            controller: precioCtrl,
          ),
          const Text(
            'Tipo de casa',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: tipoCasaSeleccionado,
            hint: const Text(
              'Selecciona tipo de casa',
              style: TextStyle(fontSize: 10),
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            items: ['Una planta', 'Dos plantas', 'Otro tipo']
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option, style: const TextStyle(fontSize: 15)),
                  ),
                )
                .toList(),
            onChanged: onTipoCasaChanged,
            validator: (value) =>
                value == null ? 'Selecciona tipo de casa' : null,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: InputQty(
                  titleTipo: 'Cupo',
                  cantidad: cupo,
                  onChanged: onCupoChanged,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: InputQty(
                  titleTipo: 'Cuartos',
                  cantidad: cuartos,
                  onChanged: onCuartosChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InputQty extends StatelessWidget {
  const InputQty({
    super.key,
    required this.titleTipo,
    required this.cantidad,
    required this.onChanged,
  });

  final String titleTipo;
  final int cantidad;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleTipo, style: const TextStyle(fontSize: 13)),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (cantidad > 0) onChanged(cantidad - 1);
                  },
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.remove,
                      color: Color(0xFF64748B),
                      size: 17,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '$cantidad',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => onChanged(cantidad + 1),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: const Center(
                    child: Icon(Icons.add, color: Color(0xFF0F172A), size: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardUbicacion extends StatelessWidget {
  const CardUbicacion({
    super.key,
    required this.calleCtrl,
    required this.numInteriorCtrl,
    required this.cpCtrl,
    required this.estadoSeleccionado,
    required this.onEstadoChanged,
  });

  final TextEditingController calleCtrl;
  final TextEditingController numInteriorCtrl;
  final TextEditingController cpCtrl;
  final String? estadoSeleccionado;
  final ValueChanged<String?> onEstadoChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardOption(
                  title: 'Calle',
                  hintText: 'Ej. Av Lopez Mateos',
                  controller: calleCtrl,
                ),
                CardOption(
                  title: 'Numero interior',
                  hintText: 'Ej. 123',
                  controller: numInteriorCtrl,
                ),
                CardOption(
                  title: 'Region',
                  hintText: 'Codigo postal',
                  controller: cpCtrl,
                ),
                CardOption(
                  hintText: 'Selecciona el estado',
                  title: 'Estado',
                  estados: true,
                  estadoSeleccionado: estadoSeleccionado,
                  onEstadoChanged: onEstadoChanged,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                MapaUbi(
                  mapaUrl: 'assets/images/mapa/image.png',
                  size: MediaQuery.of(context).size,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardOption extends StatelessWidget {
  const CardOption({
    super.key,
    this.estados = false,
    required this.hintText,
    required this.title,
    this.controller,
    this.horizontalPad,
    this.estadoSeleccionado,
    this.onEstadoChanged,
  });

  final String hintText;
  final double? horizontalPad;
  final String title;
  final bool estados;
  final TextEditingController? controller;
  final String? estadoSeleccionado;
  final ValueChanged<String?>? onEstadoChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 9,
        horizontal: horizontalPad ?? 14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          if (estados)
            DropdownButtonFormField<String>(
              isExpanded: true,
              isDense: true,
              value: estadoSeleccionado,
              hint: Text(title, style: const TextStyle(fontSize: 10)),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: estadosMexico
                  .map(
                    (option) => DropdownMenuItem(
                      value: option,
                      child: Text(option, style: const TextStyle(fontSize: 15)),
                    ),
                  )
                  .toList(),
              onChanged: onEstadoChanged,
              validator: (value) =>
                  value == null ? 'Selecciona un estado' : null,
            ),
          if (!estados)
            TextFormField(
              controller: controller,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Campo requerido'
                  : null,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
