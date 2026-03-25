import datetime
from domain.entities.usuario import Usuario
from excepciones.usuarios.exepciones_usuario import *
from helpers.usuarios.usuariosRoles import Roles
from helpers.usuarios.hashear_password  import HashPass
class UsuarioService:
    def __init__(self,repo):
        self.repo = repo

    def _existeUsuario(self,curp : str) -> bool:
        return self.repo.usuarioExiste(curp)

    def _existeCorreo(self,correo:str)-> bool:
        return self.repo.correoExistente(correo)

    def _existeTelefono(self,telefono:str)->bool:
        return self.repo.telefonoExiste(telefono) 
    
    def obtenerUsuarios(self):
        return self.repo.obtenerUsuarios()
    
    
    def obtenerUsuario(self,curp:str):
        if(not self._existeUsuario(curp)):
            raise UsuarioNoEncontrado(curp)
        return self.repo.obtenerUsuarioCurp(curp)
    
    def actualizarUsuario(self,curp:str,data):
        if(not self._existeUsuario(curp)):
            raise UsuarioNoEncontrado(curp)
        self.repo.actualizarUsuario(curp,data)
        return self.repo.obtenerUsuarioCurp(curp) 
    
    def borrarUsuario(self, curp:str):
        if(not self._existeUsuario(curp)):
            raise UsuarioNoEncontrado(curp)
        self.repo.borrarUsuario(curp)
    
    def crearUsuario(self, dto : Usuario):
        if(self._existeUsuario(dto.curp)):
            raise UsuarioYaExiste(dto.curp)
        if(self._existeCorreo(dto.correo)):
            raise CorreoYaExiste(dto.correo)
        if(self._existeTelefono(dto.telefono)):
            raise TelefonoYaExiste(dto.telefono)
        
        usuario = Usuario(
            dto.curp,
            dto.nombres,
            dto.apellidos,
            dto.correo,
            dto.telefono,
            dto.rol,
            dto.fecha_registro,
            dto.calle,
            dto.num_interior,#ACUERDATE DE CAMBIARLO PENEJO
            dto.codigo_postal,
            dto.ciudad,
           HashPass.generarHash(dto.contrasenia),
            dto.municipio
        )
        usuario = self.repo.crearUsuario(usuario)
        return usuario
        
        
        
        
    