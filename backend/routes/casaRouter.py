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

@router.get("/{id}",response_model=CasaOut,status_code=200)
def obtenerCasa(id):
    try:
        return service.obtenerCasa(id)
    except Exception as e:
        raise HTTPException(
            status_code=401,
            detail=str(e)
        )
        

@router.post("/",response_model=list[CasaOut],status_code=200)
def obtenerCasas(body :CasaFiltro):
    return service.obtenerCasas(
        filtroActivo=body.filtro_activado,
        filtro=body.filtro,
        tipoFiltro=body.tipo_filtro,
        limit=body.limit,
        limitActivo=body.limiteActivo
        )
@router.get("/",response_model=list[CasaOut],status_code=200)
def obtenerCasas():
    return service.obtenerCasas()

@router.post("/register", response_model=CrearCasaDTO, status_code=201)
def crearCasa(body: CrearCasaDTO):
    try:
        return service.crearCasa(body)
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )