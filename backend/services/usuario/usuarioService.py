import datetime
from domain.entities.usuario import Usuario
from excepciones.usuarios.exepciones_usuario import *
from helpers.usuarios.usuariosRoles import Roles
from helpers.usuarios.hashear_password import HashPass
from repository.usuario_repository import RepoUsuario
from schemas.usuario.usuarioDTO import *

from schemas.reservas.reservaDTO import ReservaOUT
from schemas.region.regionDTO import RegionoOUT
from schemas.usuario.usuarioBase import PropietarioCasaBasico
from schemas.casa.Casa_DTO import CasaOutPropietario, CasaOut 
from helpers.casas.casaTipo import TipoCasa

class UsuarioService:
    def __init__(self, repo, repoReserva, repoCasa, repoResenia):
        self.repo: RepoUsuario = repo
        self.repoCasa = repoCasa
        self.repoReserva = repoReserva
        self.repoResenia = repoResenia

    def _existeUsuario(self, curp: str) -> bool:
        return self.repo.usuarioExiste(curp)

    def _existeCorreo(self, correo: str) -> bool:
        return self.repo.correoExistente(correo)

    def _existeTelefono(self, telefono: str) -> bool:
        return self.repo.telefonoExiste(telefono) 
    
    def obtenerUsuarios(self):
        return self.repo.obtenerUsuarios()
    
    def iniciarSesion(self, email: str, password: str):
        if self.repo.correoExistente(email):
            passEnc = HashPass.generarHash(password)
    
    def obtenerUsuario(self, curp: str):
        if not self._existeUsuario(curp):
            raise UsuarioNoEncontrado(curp)
        usuario: Usuario = self.repo.obtenerUsuarioCurp(curp)
        
        reservasData = self.repoReserva.obtenerReservas(curp)
        reservas = []
        if reservasData:
            for data in reservasData:
                casaObj = CasaOut(
                    id_propietario=data['propietario_curp'],
                    id_region=data['codigo_postal'],
                    id=data['id_casa'],
                    cupo=data['cupo'],
                    tipo=data['tipo'],
                    imagen=data['imagen'],
                    cuartos=data['cuartos'],
                    calle=data['calle'],
                    num_interior=data['num_interior'],
                    precio=data['precio'],
                    titulo=data['titulo'],
                    region=RegionoOUT(
                        codigo_postal=data['codigo_postal'],
                        estado=data['estado'],
                        municipio=data['municipio']
                    ),
                    propietario=PropietarioCasaBasico(
                        apellidos=data['propietario_apellidos'],
                        nombres=data['propietario_nombre'],
                        curp=data['propietario_curp'],
                        fecha_registro=data['propietario_registro']
                    )
                )
                
                reserva = ReservaOUT(
                    idCasa=casaObj.id,
                    idComprador=data['comprador_curp'],
                    casa=casaObj,
                    estado=data['estado_reserva'],
                    id_reserva=data['id_reserva'],
                    fecha_fin=data['fecha_fin'],
                    fecha_inicio=data['fecha_inicio']
                )
                reservas.append(reserva)

        resenias = self.repoResenia.obtenerReseniaResumen(curp)
        usuario['totalResenias'] = 0
        usuario['calificacion_promedio'] = 0.0
        
        if resenias:
            resumen = resenias[0]
            usuario['totalResenias'] = resumen['total_resenias']
            usuario['calificacion_promedio'] = resumen['calificacion_promedio']
            
        casas = []
        if usuario['rol'] == 'vendedor':
            casasData = self.repoCasa.obtenerCasasCurp(curp)
            for casa in casasData:            
                region = RegionoOUT(
                    codigo_postal=casa['codigo_postal'],
                    estado=casa['estado'],
                    municipio=casa['municipio']
                )
                casaOut = CasaOutPropietario(
                    id=casa['id'],
                    titulo=casa['titulo'],
                    cupo=int(casa['cupo']),
                    tipo=TipoCasa.convertirTipoCasa(casa['tipo']),
                    imagen=casa['imagen'],
                    cuartos=casa['cuartos'],
                    calle=casa['calle'],
                    num_interior=casa['num_interior'],
                    precio=float(casa['precio']),
                    id_region=casa['id_region'],
                    region=region,
                    id_propietario=casa['id_propietario']
                )
                print(casaOut.__dict__)
                casas.append(casaOut)
            

        return UsuarioOut(
            curp=usuario['curp'],
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

    def actualizarUsuario(self, curp: str, data):
        if not self._existeUsuario(curp):
            raise UsuarioNoEncontrado(curp)
        self.repo.actualizarUsuario(curp, data)
        return self.repo.obtenerUsuarioCurp(curp) 
    
    def borrarUsuario(self, curp: str):
        if not self._existeUsuario(curp):
            raise UsuarioNoEncontrado(curp)
        self.repo.borrarUsuario(curp)
    
    def crearUsuario(self, dto: Usuario):
        if self._existeUsuario(dto.curp):
            raise UsuarioYaExiste(dto.curp)
        if self._existeCorreo(dto.correo):
            raise CorreoYaExiste(dto.correo)
        if self._existeTelefono(dto.telefono):
            raise TelefonoYaExiste(dto.telefono)
        usuarioNew = Usuario(
           curp= dto.curp,
           nombres= dto.nombres,
           apellidos= dto.apellidos,
           correo= dto.correo,
           telefono= dto.telefono,
           rol= dto.rol,
           fecha_registro= dto.fecha_registro,
           calle= dto.calle,
           num_interior= dto.num_interior,
           codigo_postal= dto.codigo_postal,
           ciudad= dto.ciudad,
           contrasenia= HashPass.generarHash(dto.contrasenia),
           municipio= dto.municipio,
        )
        print(usuarioNew.municipio)
        return self.repo.crearUsuario(usuarioNew)