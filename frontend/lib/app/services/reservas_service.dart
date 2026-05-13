import 'package:lejos_de_casa_front/domain/entities/reserva.dart';
import 'package:lejos_de_casa_front/domain/repositories/reservas_repository.dart';

class ReservasService {
  final ReservasRepository repo;
  ReservasService(this.repo);

  Future<List<Reserva>> obtenerReservasUsuario(String curp) async {
    if (curp.isEmpty) throw Exception('Curp invalida');
    return await repo.obtenerReservasUsuario(curp);
  }
}
