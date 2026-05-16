import 'package:lejos_de_casa_front/domain/entities/reserva.dart';
import 'package:lejos_de_casa_front/domain/repositories/reservas_repository.dart';
import 'package:lejos_de_casa_front/infrastructure/data/reservas_data.dart';

class ReservasRepositoryImpl extends ReservasRepository {
  ReservasData dataSource;
  ReservasRepositoryImpl(this.dataSource);

  @override
  Future<List<Reserva>> obtenerReservasUsuario(String curp) async {
    final models = await dataSource.obtenerReservasUsuario(curp);
    return models.map((reserva) => reserva.toEntity()).toList();
  }

  @override
  Future<Reserva> crearReserva(int idCasa, String idComprador) async {
    final model = await dataSource.reservarCasa(idCasa, idComprador);
    return model.toEntity();
  }
}
