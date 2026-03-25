import datetime
from helpers.usuarios.usuariosRoles import Roles

class Usuario:
    def __init__(self,
    curp : str,
    nombres: str,
    apellidos : str,
    correo : str,
    telefono : str,
    rol: Roles,
    fecha_registro : datetime,
    calle : str,
    num_interior: int,
    codigo_postal: str,
    ciudad : str,
    contrasenia: str,
    municipio: str):
        self.curp = curp
        self.nombres = nombres
        self.apellidos = apellidos
        self.correo =  correo
        self.telefono = telefono
        self.rol = rol
        self.fecha_registro = fecha_registro
        self.calle = calle
        self.num_interior = num_interior
        self.codigo_postal = codigo_postal
        self.ciudad = ciudad
        self.municipio = municipio
        self.contrasenia =  contrasenia