from pydantic import BaseModel
from datetime import datetime

class NotificacionOUT(BaseModel):
    id_notificacion: int
    id_destinatario: str | None = None
    id_emisor: str
    tipo : str
    fecha_envio : datetime
    leido: bool
    mensaje: str
    nombre_emisor:str | None = None
    apellidos_emisor: str | None = None