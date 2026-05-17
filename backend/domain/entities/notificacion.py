from datetime import datetime

class Notificacion:
    def __init__(
        self,
        id_notificacion : int,
        id_destinatario: str,
        id_emisor: str,
        tipo: str,
        mensaje:str,
        leido: bool = False,
        fecha_envio: datetime = None
        ):
        self.id_destinatario = id_destinatario
        self.id_notificacion = id_notificacion
        self.id_emisor = id_emisor
        self.tipo = tipo
        self.fecha_envio = fecha_envio
        self.leido = leido
        self.mensaje = mensaje
    