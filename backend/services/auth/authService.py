from repository.auth_repository import AuthRepository
from domain.entities.auth import Auth
from services.auth.auth_jwt import AuthJwt
from helpers.usuarios.hashear_password import HashPass
class AuthService:
    def __init__(self,repo):
        self.repo: AuthRepository = repo

    def verificarContrasenia(self,passw:str,passHash:str):
        return HashPass.verificarHash(passw,passHash)
        
    
    def login(self,correo : str ,password: str) :
        if(self.existeUsuario(correo) is None):
            return None
        passworHash = self.repo.obtenerPassPorEmail(correo)[0]
        if(not self.verificarContrasenia(password,passworHash) ):
            return None
        userRepo = self.repo.obtenerDatosUsuario(correo)
        userToDict = {'id': userRepo['curp'], 'nombre':userRepo['nombres'],'correo':userRepo['correo']}
        token = AuthJwt.createToken(userToDict)
        responseAuth = Auth(token,'bearer',600,userToDict)
        print('aceeso correcto')
        return responseAuth 
        
    
    def existeUsuario(self,correo) -> bool:
        return self.repo.usuarioExiste(correo)
    
    