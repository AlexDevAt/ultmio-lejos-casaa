from helpers.casas.casaTipo import TipoCasa

class Casa:
    def __init__(
        self,
        id,
        titulo,
        cupo,
        tipo,
        imagen,
        cuartos,
        calle,
        num_interior,
        precio,
        idRegion,
        id_propietario
    ):
        self.id = id
        self.titulo = titulo
        self.cupo = cupo
        self.tipo = tipo
        self.imagen = imagen
        self.cuartos = cuartos
        self.calle = calle
        self.num_interior = num_interior
        self.precio = precio
        self.idRegion = idRegion
        self.id_propietario = id_propietario