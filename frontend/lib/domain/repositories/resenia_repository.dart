import 'package:lejos_de_casa_front/domain/entities/resenia.dart';
import 'package:lejos_de_casa_front/infrastructure/models/resenia/resenia_model.dart';

abstract class ReseniaRepository {
  Future<List<Resenia>> obtenerResenias(dynamic id);
}
