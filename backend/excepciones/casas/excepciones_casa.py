
#TODO Falta agregar la direcion de la casa existente
class casaConMismaDir(Exception):
    def __init__(self):
        super().__init__(f"Ya existe una casa con la dirrecion : :")
        
class NoExisteCasa(Exception):
    def __init__(self):
        super().__init__('No existe ninguna casa con esos datos')