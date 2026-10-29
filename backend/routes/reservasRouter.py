from fastapi import APIRouter, HTTPException,Depends
from schemas.reservas.reservaDTO import *
from repository.casa_repository import RepoCasa
from providers import reservaService 
router = APIRouter()



@router.get("/{curp}",response_model=list[ReservaOUT],status_code=200)
def obtenerReservasUsuario(curp: str):
    try:
        return reservaService.obtenerReservas(curp)
    except Exception as e:
        raise HTTPException(
            detail=str(e)
        )

@router.get("/casas/{id}",response_model=list[ReservaOUTCasa],status_code=200)
def obtenerReservasCasa(id: int):
    try:
        return reservaService.obtenerReservasCasa(id)
    except Exception as e:
        raise HTTPException(
            detail=str(e)
        )
    
        
@router.post("/crear",response_model=ReservaCrearOut,status_code=201)
async def crearReserva(body : ReservaCrear):
    repoCasa = RepoCasa()
    try:
        return await reservaService.crearReserva(body)
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )
        
    