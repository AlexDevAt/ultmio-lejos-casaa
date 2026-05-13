from schemas.casa.Casa_DTO import CasaOutFull
from schemas.usuario.usuarioDTO import PropietarioCasaBasico
from datetime import datetime
from pydantic import BaseModel

class ReservaOUT(BaseModel):
    id: int
    fecha_inicio: datetime
    fecha_fin:datetime
    estado:str
    casa:CasaOutFull
    comprador:PropietarioCasaBasico