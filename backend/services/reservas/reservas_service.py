from domain.entities.reservas import Reserva
from repository.reservas_repository import ReservarioRepository
from schemas.casa.Casa_DTO import CasaOut
from schemas.usuario.usuarioBase import PropietarioCasaBasico
from schemas.region.regionDTO import RegionoOUT
from schemas.reservas.reservaDTO import ReservaOUT, ReservaCrearOut
from datetime import datetime
class ReservasService:
    def __init__(self, repo, notificacionService, casaService, webSocketService):
        self.repo: ReservarioRepository = repo
        self.notificacionService = notificacionService
        self.casaService = casaService
        self.webSocketService = webSocketService
        
    async def crearReserva(self, dto):
        reserva = Reserva(
            id_reserva=None,
            estado=dto.estado,
            fecha_fin=dto.fecha_fin,
            fecha_inicio=dto.fecha_inicio,
            id_casa=dto.idCasa,
            idComprador=dto.idComprador
        )
        reserva, id_reserva = self.repo.crearReserva(reserva)
        casa: CasaOut = self.casaService.obtenerCasa(dto.idCasa)
        
        reservaDTO = ReservaCrearOut(
            casa=casa,
            estado=reserva.estado,
            fecha_fin=reserva.fecha_fin,
            idComprador=reserva.idComprador,
            fecha_inicio=reserva.fecha_inicio,
            id_reserva=id_reserva,
            idCasa=casa.id
        )
        noti = self.notificacionService.crearNotificacion(
            reservaDTO.idComprador,
            reservaDTO.casa.id_propietario,
            "reserva",
            "El usuario mando la reservacion",
            datetime.now()
        )
        await self.webSocketService.emitirHaciaUsuario(
            casa.propietario.curp,
            'casa_reservada',
            noti.__dict__
        )
        
        return reservaDTO
    
    def obtenerReservas(self, id, obtenerPropietario: bool = True):
        reservasData = self.repo.obtenerReservas(id)
        if reservasData is None:
            return None
        reservasMapeadas = []
        for data in reservasData:
            casaObj = CasaOut(
                id_propietario=data['propietario_curp'],
                id_region=data['codigo_postal'],
                id=data['id_casa'],
                cupo=data['cupo'],
                tipo=data['tipo'],
                imagen=data['imagen'],
                cuartos=data['cuartos'],
                calle=data['calle'],
                num_interior=data['num_interior'],
                precio=data['precio'],
                titulo=data['titulo'],
                region=RegionoOUT(
                    codigo_postal=data['codigo_postal'],
                    estado=data['estado'],
                    municipio=data['municipio']
                ),
                propietario=PropietarioCasaBasico(
                    apellidos=data['propietario_apellidos'],
                    nombres=data['propietario_nombre'],
                    curp=data['propietario_curp'],
                    fecha_registro=data['propietario_registro']
                )
            )
            reserva = ReservaOUT(
                idCasa=casaObj.id,
                idComprador=data['comprador_curp'],
                casa=casaObj,
                estado=data['estado_reserva'],
                id_reserva=data['id_reserva'],
                fecha_fin=data['fecha_fin'],
                fecha_inicio=data['fecha_inicio']
            )
            reservasMapeadas.append(reserva)
        return reservasMapeadas