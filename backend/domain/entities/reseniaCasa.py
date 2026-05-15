from datetime import datetime

class ReseniaCasa:
    def __init__(self, id: int, calificacion: int, comentario: str, id_casa: int, comprador, fecha: datetime):
        self.id = id
        self.calificacion = calificacion
        self.comentario = comentario
        self.id_casa = id_casa
        self.comprador = comprador
        self.fecha = fecha