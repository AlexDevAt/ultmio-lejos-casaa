from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import usuarioRouter
from routes import casaRouter
from routes import authRouter
from routes import reservasRouter
from routes import reseniaRouter
from routes import webSocketPrueba
from routes import notificacionRouter
app = FastAPI()


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)



app.include_router(
    notificacionRouter.router,
    prefix="/notificacion",
    tags=['notificacion']
)

app.include_router(
    usuarioRouter.router,
    prefix="/usuarios",
    tags=['usuarios']
)


app.include_router(
    reservasRouter.router,
    prefix="/reservas",
    tags=['reservas']
)

app.include_router(
    reseniaRouter.router,
    prefix="/resenias",
    tags=['resenias']
)

app.include_router(
    webSocketPrueba.router,
    prefix="/ws",
    tags=['ws']
)



app.include_router(
    casaRouter.router,
    prefix="/casas",
    tags=['casas']
)

app.include_router(
    authRouter.router,
    prefix="/auth",
    tags=['auth']
)



