from helpers.casas.casaTipo import TipoCasa

class Casa:
    def __init__(
        self,
        id = None,
        titulo= None,
        cupo= None,
        tipo= None,
        imagen= None,
        cuartos= None,
        calle= None,
        num_interior= None,
        precio= None,
        idRegion= None,
        id_propietario= None
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