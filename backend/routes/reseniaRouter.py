
from repository.resenia_repository import ReseniaRepository
from services.resenia.reseniaServicio import ReseniaService
from schemas.resenia.reseniaDTO import ReseniaOut
from fastapi import APIRouter, HTTPException,Body
router = APIRouter()
repo = ReseniaRepository()
service = ReseniaService(repo)


@router.get("/{dato}",response_model=list[ReseniaOut],status_code=200)
def obtenerResenias(dato):
    try:
        return service.obtenerResenias(dato)
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )