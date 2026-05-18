import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/presentation/widgets/btn_form.dart';
import 'package:lejos_de_casa_front/presentation/widgets/card_opcion.dart';
import 'package:lejos_de_casa_front/presentation/widgets/mapa_ubi.dart';

final boxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(20),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.shade300.withValues(),
      blurRadius: 2,
      spreadRadius: 1,
      offset: Offset(0, 1),
    ),
  ],
);

class CrearCasa extends StatelessWidget {
  const CrearCasa({super.key});
  static String name = 'registrar_casa';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
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
          child: Form(child: _CrearCasaView()),
        ),
      ),
    );
  }
}

class _CrearCasaView extends StatelessWidget {
  const _CrearCasaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 18),
        CardFotoCasa(),
        SizedBox(height: 15),
        TipoDeInfo(tipo: 'Informacion general', func: () => ()),
        SizedBox(height: 15),
        CardInfoGeneral(),
        SizedBox(height: 15),
        TipoDeInfo(tipo: 'Ubicacion', func: () => ()),
        SizedBox(height: 15),
        CardUbicacion(),
        SizedBox(height: 10),
        BtnFormulario(text: 'Crear casa', func: () => (), width: 0, height: 0)

      ],
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
        SizedBox(width: 10),
        Text(tipo, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }
}

class CardUbicacion extends StatelessWidget {
  const CardUbicacion({super.key});

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
                CardOption(),
                CardOption(),
                CardOption(),
                CardOption(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MapaUbi(
                    mapaUrl: 'assets/images/mapa/image.png',
                    size: MediaQuery.of(context).size,
                  ),
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
  const CardOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Calle', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text('ej. Av Central', style: TextStyle(fontSize: 14)),
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 6),
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

class CardInfoGeneral extends StatelessWidget {
  const CardInfoGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: boxDecoration,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            'Tipo de casa',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),

          DropdownButtonFormField<String>(
            hint: Text(
              'Selecciona tipo de casa',
              style: TextStyle(fontSize: 10),
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              border: OutlineInputBorder(
                gapPadding: 12,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            items: ['Una planta', 'Dos plantas', 'Otro tipo']
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option, style: TextStyle(fontSize: 15)),
                  ),
                )
                .toList(),
            onChanged: (value) => (),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: InputQty(titleTipo: 'Cupo')),
              SizedBox(width: 20),
              Expanded(child: InputQty(titleTipo: 'Cuartos')),
            ],
          ),
        ],
      ),
    );
  }
}

class InputQty extends StatefulWidget {
  const InputQty({super.key, required this.titleTipo});
  final String titleTipo;

  @override
  State<InputQty> createState() => _InputQtyState();
}

class _InputQtyState extends State<InputQty> {
  int _cantidad = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.titleTipo, style: TextStyle(fontSize: 13)),
        Container(
          height: 40, // Altura del control
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15), // Bordes redondeados
            border: Border.all(
              color: const Color(0xFFE2E8F0), // Borde gris claro suave
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Botón de menos (-)
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (_cantidad > 0) {
                      // Evita números negativos
                      setState(() => _cantidad--);
                    }
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

              // Número central
              Expanded(
                child: Center(
                  child: Text(
                    '$_cantidad',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
              ),

              // Botón de más (+)
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Evita números negativos
                    setState(() => _cantidad++);
                  },
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

class CardFotoCasa extends StatelessWidget {
  const CardFotoCasa({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: boxDecoration,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            child: _BoxImage(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Foto de la casa',
                    style: TextStyle(
                      color: Color.fromARGB(255, 17, 34, 85),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Sube una fotografiía de la fachada principal',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _buttonDetalles(),
                  // _buttonDetalles()
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
  const _BoxImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(Icons.home_outlined, size: 50, color: Colors.black38),
    );
  }
}

class _buttonDetalles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: TextButton.icon(
        // label: Text('Ver mas', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        onPressed: () => (),
        style: TextButton.styleFrom(
          minimumSize: Size(0, 0),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(9),
          ),
          backgroundColor: Color(0xFF0b1636),
        ),
        label: Text(
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
