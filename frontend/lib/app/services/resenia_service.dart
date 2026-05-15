import 'package:lejos_de_casa_front/domain/entities/resenia.dart';
import 'package:lejos_de_casa_front/domain/repositories/resenia_repository.dart';

class ReseniaService {
  final ReseniaRepository repo;
  ReseniaService(this.repo);

  Future<List<Resenia>> obtenerResenias(dynamic id) async {
    return await repo.obtenerResenias(id);
  }
}
