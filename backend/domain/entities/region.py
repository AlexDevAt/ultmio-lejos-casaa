from pydantic import BaseModel

class Region():
    def __init__(
        self,
        codigo_postal = None,
        estado = None,
        municipio = None):
        self.codigo_postal = codigo_postal,
        self.estado = estado,
        self.municipio = municipio