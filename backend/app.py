from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import usuarioRouter
from routes import casaRouter
from routes import authRouter
from routes import reservasRouter
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
    reservasRouter.router,
    prefix="/reservas",
    tags=['reservas']
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



