class UsuarioYaExiste(Exception):
    def __init__(self,curp:str):
        super().__init__(f"Ya existe el usuario con el curp: {curp}")
class CorreoYaExiste(Exception):
    def __init__(self,correo:str):
        super().__init__(f"Ya se registro un usario con el correo: {correo}")
class TelefonoYaExiste(Exception):
    def __init__(self,telefono:str):
        super().__init__(f"Ya existe el numero: {telefono}")
class UsuarioNoEncontrado(Exception):
    def __init__(self,curp:str):
        super().__init__(f"No se encontro el usuario con el curp:{curp}")