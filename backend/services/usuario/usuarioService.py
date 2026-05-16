import datetime
from domain.entities.usuario import Usuario
from excepciones.usuarios.exepciones_usuario import *
from helpers.usuarios.usuariosRoles import Roles
from helpers.usuarios.hashear_password  import HashPass
from repository.usuario_repository import RepoUsuario
from services.reservas.reservas_service import ReservasService
from services.resenia.reseniaServicio import ReseniaService
from services.casa.casaService import CasaService
from schemas.usuario.usuarioDTO import *
class UsuarioService:
    def __init__(self,repo,repoReserva,repoCasa,repoResenia):
        self.repo:RepoUsuario = repo
        self.repoCasa = repoCasa
        self.repoReserva = repoReserva
        self.repoResenia = repoResenia

    def _existeUsuario(self,curp : str) -> bool:
        return self.repo.usuarioExiste(curp)

    def _existeCorreo(self,correo:str)-> bool:
        return self.repo.correoExistente(correo)

    def _existeTelefono(self,telefono:str)->bool:
        return self.repo.telefonoExiste(telefono) 
    
    def obtenerUsuarios(self):
        return self.repo.obtenerUsuarios()
    
    def iniciarSesion(self,email:str,password:str):
        if(self.repo.correoExistente(email)):
            passEnc = HashPass.generarHash(password)
            
    
    
    def obtenerUsuario(self,curp:str):
        if(not self._existeUsuario(curp)):
            raise UsuarioNoEncontrado(curp)
        usuario : Usuario =  self.repo.obtenerUsuarioCurp(curp)
        reservas = ReservasService(self.repoReserva).obtenerReservas(curp,obtenerPropietario=False)
        resenias = ReseniaService(self.repoResenia).obtenerReseniaResumen(curp)
        
        usuario['totalResenias'] = 0
        usuario['calificacion_promedio'] = 0.0
        
        if resenias:
            resumen = resenias[0] # Extraemos directo sin iterar un for innecesariamente
            usuario['totalResenias'] = resumen['total_resenias']
            usuario['calificacion_promedio'] = resumen['calificacion_promedio']
        casas = []
        if usuario['rol'] == 'vendedor':
            casas = CasaService(self.repoCasa).obtenerCasasCurp(curp)
        return UsuarioOut(
            curp = usuario['curp'],
            apellidos=usuario['apellidos'],
            calle=usuario['calle'],
            nombres=usuario['nombres'],
            ciudad=usuario['ciudad'],
            codigo_postal=usuario['codigo_postal'],
            rol=usuario['rol'],
            num_interior=usuario['num_interior'],
            correo=usuario['correo'],
            municipio=usuario['municipio'],
            telefono=usuario['telefono'],
            fecha_registro=usuario['fecha_registro'],
            calificacion_promedio=usuario['calificacion_promedio'],
            totalResenias=usuario['totalResenias'],
            casas=casas,
            reservas=reservas
            )
        

    
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
            dto.municipio,
        )
        usuario = self.repo.crearUsuario(usuario)
        return usuario
        
        
        
        
    