from fastapi import APIRouter, HTTPException,Depends
from schemas.reservas.reservaDTO import *
from repository.reservas_repository import ReservarioRepository
from services.reservas.reservas_service import ReservasService
router = APIRouter()
repo = ReservarioRepository()
service = ReservasService(repo)

@router.get("/{curp}",response_model=list[ReservaOUT],status_code=200)
def obtenerReservasUsuario(curp: str):
    try:
        return service.obtenerReservas(curp)
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )