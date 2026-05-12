from fastapi import APIRouter, HTTPException
from schemas.casa.Casa_DTO import *
from repository.casa_repository import RepoCasa 
from services.casa.casaService import  CasaService
from services.usuario.usuarioService import UsuarioService
from excepciones.usuarios.exepciones_usuario import *
from repository.usuario_repository import RepoUsuario
from services.auth.auth_jwt import AuthJwt
from datetime import datetime,timedelta
from helpers.usuarios.hashear_password import HashPass
# router = APIRouter()
# repo = RepoCasa()
# service = CasaService(repo)
# service.obtenerCasa(1)

repoUsuario = RepoUsuario()
serviceUsuario = UsuarioService(repoUsuario)
user = serviceUsuario.obtenerUsuario('HEAL950505HYNMNO05')
paylaod = {
    'userId': user['curp'],
    "exp": datetime.utcnow() + timedelta(minutes=30),
    'rol': user['rol'],
    'nombre': user['nombres']
}
token = AuthJwt.createToken(paylaod)
print(AuthJwt.desencodeToken(token))

passf = HashPass.generarHash('alexismau1')
print(passf)
correc = HashPass.verificarHash('alexismau1',passf)
print(correc)