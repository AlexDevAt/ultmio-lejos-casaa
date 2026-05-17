from repository.notificacion_repository import NotificacionRepository
from services.notificacion.notificacionService import NotificacionService
from fastapi import APIRouter, HTTPException,Body
from schemas.notificacion.notificacionDTO import NotificacionOUT
router = APIRouter()
repo = NotificacionRepository()
service = NotificacionService(repo)

@router.get("/",response_model=list[NotificacionOUT],status_code=200)
def obtenerNotificaciones():
    try:
        return service.obtenerNotificacionesNoLeidas()
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )

