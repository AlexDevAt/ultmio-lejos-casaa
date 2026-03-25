from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import usuarioRouter
from routes import casaRouter
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


app.include_router(
    usuarioRouter.router,
    prefix="/usuarios",
    tags=['usuarios']
)


app.include_router(
    casaRouter.router,
    prefix="/casas",
    tags=['casas']
)




