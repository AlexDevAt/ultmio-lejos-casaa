from datetime import datetime
from pydantic import BaseModel
from schemas.usuario.usuarioDTO import UsuarioCalificador

class ReseniaOut(BaseModel):
    calificacion: int
    comentario:str
    calificador : UsuarioCalificador
    fecha : datetime
