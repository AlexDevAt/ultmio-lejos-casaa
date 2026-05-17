from fastapi import APIRouter, HTTPException,Body
from schemas.auth.authDTO import LoginDTO
from providers import authService
router = APIRouter()


@router.post("/login",status_code=200)
def login(body : LoginDTO):
    try:
        return authService.login(body.correo,body.password)
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )
