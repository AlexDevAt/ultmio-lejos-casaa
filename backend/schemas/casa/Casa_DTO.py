from pydantic import BaseModel
import datetime
from helpers.casas.casaTipo import TipoCasa
from schemas.usuario.usuarioDTO import PropietarioCasaBasico
class CrearCasaDTO(BaseModel):
    cupo: int 
    titulo:str
    tipo: TipoCasa
    imagen : str
    cuartos : int
    precio: float
    calle: str
    num_interior : int
    idRegion : str
    id_propietario : str

class CasaOut(BaseModel):
    id: int
    titulo:str
    cupo: int 
    tipo: TipoCasa
    imagen : str
    cuartos : int
    calle: str
    num_interior : int
    precio: float
    idRegion : str
    propietario: PropietarioCasaBasico

