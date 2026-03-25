from fastapi import APIRouter, HTTPException
from schemas.casa.Casa_DTO import *
from repository.casa_repository import RepoCasa 
from services.casa.casaService import  CasaService
from excepciones.usuarios.exepciones_usuario import *
router = APIRouter()
repo = RepoCasa()
service = CasaService(repo)
service.obtenerCasas()