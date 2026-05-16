import 'package:lejos_de_casa_front/domain/entities/reserva.dart';

abstract class ReservasRepository {
  Future<List<Reserva>> obtenerReservasUsuario(String curp);
  Future<Reserva> crearReserva(int idCasa, String idComprador);
}
