from datetime import datetime
class Reserva:
    def __init__(
        self,
        id_reserva: int,
        fecha_inicio: datetime,
        fecha_fin: datetime,
        estado: str,
        id_casa : int,
        idComprador : str
    ):
        self.id_reserva = id_reserva
        self.fecha_inicio = fecha_inicio
        self.fecha_fin = fecha_fin
        self.estado = estado
        self.idCasa= id_casa
        self.idComprador = idComprador