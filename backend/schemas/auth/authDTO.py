from pydantic import BaseModel,EmailStr,Field
class LoginDTO(BaseModel):
    correo: str
    password: str    