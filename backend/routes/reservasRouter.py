from fastapi import APIRouter, HTTPException,Depends
from schemas.reservas.reservaDTO import *
from repository.reservas_repository import ReservarioRepository
from services.reservas.reservas_service import ReservasService
from services.casa.casaService import CasaService
from repository.casa_repository import RepoCasa
router = APIRouter()
repo = ReservarioRepository()
service = ReservasService(repo)


@router.get("/{curp}",response_model=list[ReservaOUT],status_code=200)
def obtenerReservasUsuario(curp: str):
    try:
        return service.obtenerReservas(curp)
    except Exception as e:
        raise HTTPException(
            detail=str(e)
        )
        
@router.post("/crear",response_model=ReservaCrearOut,status_code=201)
def crearReserva(body : ReservaCrear):
    repoCasa = RepoCasa()
    try:
        return service.crearReserva(body,CasaService(repoCasa))
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )
        
    