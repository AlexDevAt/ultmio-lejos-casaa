from domain.entities.region import Region
from domain.entities.reservas import Reserva
from repository.reservas_repository import ReservarioRepository
from schemas.casa.Casa_DTO import CasaOut
from schemas.usuario.usuarioBase import PropietarioCasaBasico
from schemas.region.regionDTO import RegionoOUT
from schemas.reservas.reservaDTO import ReservaOUT
from schemas.reservas.reservaDTO import ReservaCrearOut
from services.casa.casaService import CasaService

class ReservasService:
    def __init__(self,repo,):
        self.repo:ReservarioRepository = repo
        
    def crearReserva(self,dto ,casaService :CasaService):
        reserva = Reserva(
            id_reserva=None,
            estado=dto.estado,
            fecha_fin=dto.fecha_fin,
            fecha_inicio=dto.fecha_inicio,
            id_casa=dto.idCasa,
            idComprador=dto.idComprador
        )
        reserva,id = self.repo.crearReserva(reserva)
        casa : CasaOut = casaService.obtenerCasa(dto.idCasa)
        return ReservaCrearOut(
            casa=casa,
            estado=reserva.estado,
            fecha_fin=reserva.fecha_fin,
            idComprador=reserva.idComprador,
            fecha_inicio=reserva.fecha_inicio,
            id_reserva=id,
            idCasa=casa.id
        )
    
    
    def obtenerReservas(self,id,obtenerPropietario: bool = True, ):
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
            if obtenerPropietario:
                comprador=PropietarioCasaBasico(
                    apellidos=data['comprador_apellidos'],
                    nombres=data['comprador_nombre'],
                    curp=data['comprador_curp'],
                    fecha_registro=data['comprador_registro']
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
    
    
            
            
        