from fastapi import APIRouter, HTTPException,Body
from repository.auth_repository import AuthRepository
from services.auth.authService import AuthService
from schemas.auth.authDTO import LoginDTO
router = APIRouter()
repo = AuthRepository()
service = AuthService(repo)

@router.post("/login",status_code=200)
def login(body : LoginDTO):
    print(body.correo)
    print(body.password)
    try:
        return service.login(body.correo,body.password)
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )
