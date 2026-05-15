import 'package:lejos_de_casa_front/domain/entities/resenia.dart';
import 'package:lejos_de_casa_front/domain/repositories/resenia_repository.dart';
import 'package:lejos_de_casa_front/infrastructure/data/resenia_data.dart';

class ReseniaRepositoryImpl extends ReseniaRepository {
  final ReseniaData dataSource;
  ReseniaRepositoryImpl(this.dataSource);

  @override
  Future<List<Resenia>> obtenerResenias(dynamic id) async {
    final models = await dataSource.obtenerReseniasCasa(id);

    return models.map((resenia) => resenia.toEntity()).toList();
  }
}
