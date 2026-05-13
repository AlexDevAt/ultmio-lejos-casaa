from domain.entities.region import Region
from domain.entities.reservas import Reserva
from repository.reservas_repository import ReservarioRepository
from schemas.casa.Casa_DTO import CasaOutFull
from schemas.usuario.usuarioDTO import PropietarioCasaBasico
from schemas.region.regionDTO import RegionoOUT
from schemas.reservas.reservaDTO import ReservaOUT

class ReservasService:
    def __init__(self,repo):
        self.repo:ReservarioRepository = repo
    
    def obtenerReservas(self,id):
        reservasData = self.repo.obtenerReservas(id)
        if reservasData is None:
            return None
        
        reservasMapeadas = []
        
        for data in reservasData:
            casaObj = CasaOutFull(
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
            comprador=PropietarioCasaBasico(
                apellidos=data['comprador_apellidos'],
                nombres=data['comprador_nombre'],
                curp=data['comprador_curp'],
                fecha_registro=data['comprador_registro']
                )
            reserva = ReservaOUT(
                casa=casaObj,
                comprador=comprador,
                estado=data['estado_reserva'],
                id=data['id_reserva'],
                fecha_fin=data['fecha_fin'],
                fecha_inicio=data['fecha_inicio']
            )
            reservasMapeadas.append(reserva)
        return reservasMapeadas
            
            
        