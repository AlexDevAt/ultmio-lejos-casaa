import 'package:lejos_de_casa_front/domain/entities/propietario.dart';
import 'package:lejos_de_casa_front/domain/entities/region.dart';

enum TipoCasa { unaPlanta, dosPlantas, otroTipo }

class Casa {
  final int id;
  final String titulo;
  final int cupo;
  final TipoCasa tipo;
  final String imagen;
  final int cuartos;
  final String calle;
  final int numInterior;
  final double precio;
  final String idRegion;
  final String idPropietario;
  final Region? region;
  final Propietario? propietario;

  Casa({
    required this.id,
    required this.cupo,
    required this.tipo,
    required this.imagen,
    required this.cuartos,
    required this.calle,
    required this.numInterior,
    required this.precio,
     this.region,
     this.propietario,
    required this.titulo, required this.idRegion, required this.idPropietario,
  });
}
