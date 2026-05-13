from fastapi import APIRouter, HTTPException,Depends
from schemas.usuario.usuarioDTO import *
from repository.usuario_repository import RepoUsuario
from services.usuario.usuarioService import UsuarioService
from excepciones.usuarios.exepciones_usuario import *
from services.auth.auth_jwt import AuthJwt
router = APIRouter()
repo = RepoUsuario()
service = UsuarioService(repo)




@router.post("/register",response_model=UsuarioOut,status_code=201)
def crearUsuario(body : UsuarioCreate):
    
    try:
        return service.crearUsuario(body)
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )
        
@router.get("/me",response_model=UsuarioOut,status_code=201,)
def obtenerUsuarioLog(data: dict = Depends(AuthJwt.validarToken)):
    print(data['id'])
    try:
        user =service.obtenerUsuario(data['id'])
        return user
    except UsuarioNoEncontrado as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )


@router.delete("/{curp}",status_code=204)
def borrarUsuario(curp: str):
    try:
        service.borrarUsuario(curp)
    except UsuarioNoEncontrado as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )
        


@router.get("/{curp}",response_model=UsuarioOut,status_code=200)
def obtenerUsuario(curp: str):
    try:
        return service.obtenerUsuario(curp)
    except UsuarioNoEncontrado as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )

@router.patch("/{curp}",response_model=UsuarioOut,status_code=200)
def actualizarUsuario(curp:str, data:dict):
    try:
        return service.actualizarUsuario(curp,data)
    except UsuarioNoEncontrado as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )

@router.get("/",response_model=list[UsuarioOut],status_code=200)
def obtenerUsuarios():
    return service.obtenerUsuarios()
