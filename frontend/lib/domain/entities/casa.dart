import 'package:lejos_de_casa_front/domain/entities/propietario.dart';

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
  final Propietario propietario;

  Casa({
    required this.id,
    required this.cupo,
    required this.tipo,
    required this.imagen,
    required this.cuartos,
    required this.calle,
    required this.numInterior,
    required this.precio,
    required this.idRegion,
    required this.propietario, required this.titulo,
  });
}

//TODO: CAMBIAR EL ID D REGION POR LOS DATOS DE LA REGION DESDE EL BACK
