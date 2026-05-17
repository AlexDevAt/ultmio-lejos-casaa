from fastapi import APIRouter, HTTPException,Body
from schemas.notificacion.notificacionDTO import NotificacionOUT
from providers import notificacionService as service
router = APIRouter()


@router.get("/{curp}",response_model=list[NotificacionOUT],status_code=200)
def obtenerNotificaciones(curp: str):
    try:
        return service.obtenerNotificacionesNoLeidas(curp)
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )

# @router.post('/',response_model=NotificacionOUT,status_code=200)

