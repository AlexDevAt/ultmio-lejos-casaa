# services/notificacion/notificacionService.py
from repository.notificacion_repository import NotificacionRepository
from schemas.notificacion.notificacionDTO import *
from domain.entities.notificacion import Notificacion

class NotificacionService:
    def __init__(self, repo, serviceUsuario=None):
        self.repo: NotificacionRepository = repo
        self.serviceUsuario = serviceUsuario
    
    def crearNotificacion(self, idEmisor: str, id_receptor: str, tipo, mensaje,fecha):
        notiEntity = Notificacion(-1, id_receptor, idEmisor, tipo, mensaje,fecha_envio=fecha)
        id_noti = self.repo.save(notiEntity)
        notiEntity.id_notificacion = id_noti
        usuario = self.serviceUsuario.obtenerUsuario(idEmisor)
        return NotificacionOutForJson(
            apellidos_emisor=usuario.apellidos,
            fecha_envio=notiEntity.fecha_envio.isoformat(),
            id_emisor=notiEntity.id_emisor,
            id_destinatario=notiEntity.id_destinatario,
            leido=notiEntity.leido,
            id_notificacion=notiEntity.id_notificacion,
            mensaje=notiEntity.mensaje,
            nombre_emisor=usuario.nombres,
            tipo=notiEntity.tipo,
        )
    
    def obtenerNotificacionesNoLeidas(self, curp):
        notificaciones = self.repo.obtenerNotificacionesNoLeidas(curp)
        if notificaciones is None:
            return []
        listNotis = []
        for data in notificaciones:
            noti = NotificacionOUT(
                fecha_envio=data['fecha_envio'],
                id_destinatario=data['id_destinatario'],
                id_emisor=data['id_emisor'],
                id_notificacion=data['id_notificacion'],
                leido=True if data['leido'] == 1 else False,
                tipo=data['tipo'],
                mensaje=data['mensaje'],
                nombre_emisor=data['nombre_emisor'],
                apellidos_emisor=data['apellidos_emisor']
            )
            listNotis.append(noti)
        return listNotis