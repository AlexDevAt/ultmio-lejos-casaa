from pydantic import BaseModel

class RegionoOUT(BaseModel):
    codigo_postal: str | None = None
    estado: str | None = None
    municipio: str | None = None