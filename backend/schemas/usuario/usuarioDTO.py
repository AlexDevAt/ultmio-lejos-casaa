from pydantic import BaseModel,EmailStr,Field
from helpers.usuarios.usuariosRoles import Roles
from schemas.casa.Casa_DTO import CasaOutPropietario
from schemas.reservas.reservaDTO import ReservaOUT
import datetime

class UsuarioCreate(BaseModel):
    curp: str = Field(pattern=r'^[A-Z]{4}[0-9]{6}[A-Z]{6}[0-9]{2}$')
    nombres:  str = Field(min_length=2, max_length=255)
    apellidos : str = Field(min_length=2, max_length=255)
    correo : EmailStr
    telefono : str = Field(pattern=r'^[0-9]{10}$')
    rol: Roles
    contrasenia: str
    calle : str
    fecha_registro: datetime.datetime
    num_interior: int
    codigo_postal: str = Field( pattern=r'^[0-9]{5}$')
    ciudad : str
    municipio: str
    
class UsuarioCalificador(BaseModel):
    nombres:  str = Field(min_length=2, max_length=255)
    apellidos : str = Field(min_length=2, max_length=255)    
    
    
class UsuarioOut(BaseModel):
    curp: str 
    nombres:  str = Field(min_length=2, max_length=255)
    apellidos : str = Field(min_length=2, max_length=255)
    correo : EmailStr
    telefono : str = Field(pattern=r'^[0-9]{10}$')
    rol: Roles
    fecha_registro : datetime.datetime
    calle : str
    num_interior: int
    codigo_postal: str = Field( pattern=r'^[0-9]{5}$')
    ciudad : str
    municipio: str
    reservas:list[ReservaOUT] | None = None 
    casas: list[CasaOutPropietario] | None = None
    calificacion_promedio : float = 0
    totalResenias: int = 0
