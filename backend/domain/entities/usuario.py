import datetime
from helpers.usuarios.usuariosRoles import Roles

class Usuario:
    def __init__(self,
    curp : str= None,
    nombres: str= None,
    apellidos : str= None,
    correo : str= None,
    telefono : str= None,
    rol: Roles= None,
    fecha_registro : datetime= None,
    calle : str= None,
    num_interior: int= None,
    codigo_postal: str= None,
    ciudad : str= None,
    contrasenia: str= None,
    municipio: str= None):
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