from pydantic import BaseModel
import datetime
from helpers.casas.casaTipo import TipoCasa
from schemas.usuario.usuarioBase import PropietarioCasaBasico
from domain.entities.region import Region
from schemas.region.regionDTO import RegionoOUT
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
    
class CasaOutPropietario(BaseModel):
    id: int
    titulo:str
    cupo: int 
    tipo: TipoCasa
    imagen : str
    cuartos : int
    calle: str
    num_interior : int
    precio: float
    id_region: str
    region : RegionoOUT
    id_propietario: str





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
    id_region: str
    id_propietario: str
    region : RegionoOUT
    propietario: PropietarioCasaBasico
    
class CasaFiltro(BaseModel):
    filtro_activado: bool
    tipo_filtro:str
    filtro: str
    limit:int
    limiteActivo : bool
    
class CasaOutFull(BaseModel):
    id: int
    titulo:str
    cupo: int 
    tipo: TipoCasa
    imagen : str
    cuartos : int
    calle: str
    num_interior : int
    precio: float
    id_region:str
    id_propietario:str
    region: RegionoOUT
    propietario: PropietarioCasaBasico

