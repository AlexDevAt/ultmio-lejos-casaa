from fastapi import APIRouter, HTTPException,Depends
from schemas.usuario.usuarioDTO import *
from services.usuario.usuarioService import UsuarioService
from excepciones.usuarios.exepciones_usuario import *
from services.auth.auth_jwt import AuthJwt
from providers import usuarioService
router = APIRouter()
 



@router.post("/register",response_model=UsuarioOut,status_code=201)
def crearUsuario(body : UsuarioCreate):
    
    try:
        return usuarioService.crearUsuario(body)
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )
        
@router.get("/me",response_model=UsuarioOut,status_code=201,)
def obtenerUsuarioLog(data: dict = Depends(AuthJwt.validarToken)):
    try:
        user = usuarioService.obtenerUsuario(data['id'])
        return user
    except UsuarioNoEncontrado as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )


@router.delete("/{curp}",status_code=204)
def borrarUsuario(curp: str):
    try:
        usuarioService.borrarUsuario(curp)
    except UsuarioNoEncontrado as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )
        


@router.get("/{curp}",response_model=UsuarioOut,status_code=200)
def obtenerUsuario(curp: str):
    try:
        return usuarioService.obtenerUsuario(curp)
    except UsuarioNoEncontrado as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )

@router.patch("/{curp}",response_model=UsuarioOut,status_code=200)
def actualizarUsuario(curp:str, data:dict):
    try:
        return usuarioService.actualizarUsuario(curp,data)
    except UsuarioNoEncontrado as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )

@router.get("/",response_model=list[UsuarioOut],status_code=200)
def obtenerUsuarios():
    return usuarioService.obtenerUsuarios()
