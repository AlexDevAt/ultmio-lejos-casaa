from datetime import datetime
class Reserva:
    def __init__(
        self,
        id: str,
        fecha_inicio: datetime,
        fecha_fin: datetime,
        estado: str,
        casa,
        comprador
    ):
        self.id = id
        self.fecha_inicio = fecha_inicio
        self.fecha_fin = fecha_fin
        self.estado = estado
        self.casa = casa
        self.comprador = comprador