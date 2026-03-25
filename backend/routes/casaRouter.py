from fastapi import APIRouter, HTTPException
from schemas.casa.Casa_DTO import *
from repository.casa_repository import RepoCasa 
from services.casa.casaService import  CasaService
from excepciones.usuarios.exepciones_usuario import *
router = APIRouter()
repo = RepoCasa()
service = CasaService(repo)

@router.get("/",response_model=list[CasaOut],status_code=200)
def obtenerCasas():
    return service.obtenerCasas()

@router.get("/{filtro}/{tipoFiltro}",response_model=list[CasaOut],status_code=200)
def obtenerCasas(filtro,tipoFiltro):
    return service.obtenerCasas(filtro,tipoFiltro)

@router.post("/register", response_model=CrearCasaDTO, status_code=201)
def crearCasa(body: CrearCasaDTO):
    try:
        return service.crearCasa(body)
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )