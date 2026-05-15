from datetime import datetime

class ReseniaUsuario:
    def __init__(self, id: int, calificacion: int, comentario: str, id_casa: int, usuario,calificador, fecha: datetime):
        self.id = id
        self.calificacion = calificacion
        self.comentario = comentario
        self.comprador = usuario
        self.calificador = calificador
        self.fecha = fecha