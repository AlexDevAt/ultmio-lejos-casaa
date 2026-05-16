from enum import StrEnum 

class EstadoReserva(StrEnum):
    PENDIENTE = "pendiente"
    DENEGADA = "denegada"
    ACEPTADA = "aceptada"