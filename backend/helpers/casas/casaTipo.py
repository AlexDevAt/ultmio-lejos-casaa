from enum import StrEnum 

class TipoCasa(StrEnum):
    UNA_PLANTA = "Una planta"
    DOS_PLANTAS = "Dos plantas"
    OTRO_TIPO = "Otro tipo"
    
    @classmethod
    def convertirTipoCasa(self,tipo):
        if(tipo == 'Una planta'):
            return self.UNA_PLANTA
        if(tipo == 'Dos plantas'):
            return self.DOS_PLANTAS
        else:
            return self.OTRO_TIPO