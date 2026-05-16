import datetime
from pydantic import BaseModel, Field

class PropietarioCasaBasico(BaseModel):
    curp: str 
    nombres: str = Field(min_length=2, max_length=255) 
    apellidos: str = Field(min_length=2, max_length=255)
    fecha_registro: datetime.datetime