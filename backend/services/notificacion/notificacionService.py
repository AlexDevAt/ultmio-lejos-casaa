from repository.notificacion_repository import NotificacionRepository
from schemas.notificacion.notificacionDTO import *
class NotificacionService:
    def __init__(self,repo):
        self.repo :NotificacionRepository = repo
    
    
    def obtenerNotificacionesNoLeidas(self):
        notificaciones = self.repo.obtenerNotificacionesNoLeidas()
        if notificaciones is None:
            return 
        listNotis = []
        for data in notificaciones:
            noti = NotificacionOUT(
            fecha_envio=data['fecha_envio'],
            id_destinatario=data['id_destinatario'],
            id_emisor=data['id_emisor'],
            id_notificacion=data['id_notificacion'],
            leido=True  if data['leido']==1 else False,
            tipo=data['tipo'],
            mensaje=data['mensaje'],
            nombre_emisor=data['nombre_emisor'],
            apellidos_emisor=data['apellidos_emisor']
            )
            listNotis.append(noti)
        return listNotis