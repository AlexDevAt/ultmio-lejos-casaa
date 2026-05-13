from fastapi import APIRouter, HTTPException
from schemas.casa.Casa_DTO import *
from repository.casa_repository import RepoCasa 
from services.casa.casaService import  CasaService
from services.usuario.usuarioService import UsuarioService
from services.auth.authService import AuthService
from excepciones.usuarios.exepciones_usuario import *
from repository.usuario_repository import RepoUsuario
from services.auth.auth_jwt import AuthJwt
from datetime import datetime,timedelta
from helpers.usuarios.hashear_password import HashPass
from schemas.usuario.usuarioDTO import UsuarioCreate
from helpers.usuarios.usuariosRoles import Roles
from repository.auth_repository import AuthRepository
from fastapi import APIRouter, HTTPException,Depends
from schemas.reservas.reservaDTO import *
from repository.reservas_repository import ReservarioRepository
from services.reservas.reservas_service import ReservasService
# router = APIRouter()
# repo = AuthRepository()
# service = AuthService(repo)
# service.login('user@example.com','string')

# router = APIRouter()
# repo = RepoUsuario()
# service = UsuarioService(repo)
# usuario = UsuarioCreate(
#     curp="RPVS910421NRKJXF99",
#     nombres="Alexis",
#     apellidos="Ramirez Perez",
#     correo="alexis@example.com",
#     telefono="6403369191",
#     rol=Roles.VENDEDOR,
#     contrasenia="alexis123",
#     calle="Av Tecnologico",
#     fecha_registro="2026-05-11",
#     num_interior=12,
#     codigo_postal="28935",
#     ciudad="Colima",
#     municipio="Villa de Alvarez"
# )
# service.crearUsuario(usuario)


# router = APIRouter()
# repo = RepoCasa()
# service = CasaService(repo)
# service.obtenerCasa(1)

# repoUsuario = RepoUsuario()
# serviceUsuario = UsuarioService(repoUsuario)
# user = serviceUsuario.obtenerUsuario('HEAL950505HYNMNO05')
# paylaod = {
#     'userId': user['curp'],
#     "exp": datetime.utcnow() + timedelta(minutes=30),
#     'rol': user['rol'],
#     'nombre': user['nombres']
# }
# token = AuthJwt.createToken(paylaod)
# print(AuthJwt.desencodeToken(token))

# passf = HashPass.generarHash('alexis')
# print(passf)
# correc = HashPass.verificarHash('alexis',passf)
# print(correc)

router = APIRouter()
repo = ReservarioRepository()
service = ReservasService(repo)
service.obtenerReservas('GAMM850202MDFDEF02')