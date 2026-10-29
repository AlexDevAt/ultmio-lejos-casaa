from schemas.casa.Casa_DTO import *
from schemas.usuario.usuarioBase import PropietarioCasaBasico
from datetime import datetime
from pydantic import BaseModel

class ReservaOUT(BaseModel):
    id_reserva: int
    fecha_inicio: datetime
    fecha_fin:datetime
    estado:str
    casa:CasaOut
    idComprador: str
    idCasa: int
    comprador:PropietarioCasaBasico | None = None
    
class ReservaOUTCasa(BaseModel):
    id_reserva: int
    fecha_inicio: datetime
    fecha_fin:datetime
    estado:str
    idComprador: str
    comprador:PropietarioCasaBasico | None = None
    
class ReservaCrearOut(BaseModel):
    id_reserva:int
    fecha_inicio: datetime
    fecha_fin:datetime
    estado:str
    idCasa:int
    idComprador:str
    casa: CasaOut
    
class ReservaCrear(BaseModel):
    id_reserva:int
    fecha_inicio: datetime
    fecha_fin:datetime
    estado:str
    idCasa:int
    idComprador:str