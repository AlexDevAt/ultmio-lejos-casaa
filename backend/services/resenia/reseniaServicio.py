from repository.resenia_repository import ReseniaRepository
from schemas.resenia.reseniaDTO import ReseniaOut
from schemas.usuario.usuarioDTO import UsuarioCalificador
class ReseniaService:
    def __init__(self,repo):
        self.repo:ReseniaRepository = repo
    
    def obtenerResenias(self,dato ):
        try:
            id_casa = int(dato)
            resenias =  self.repo.obtenerReseniaCasa(id_casa)
        except (ValueError, TypeError):
        # Si falla la conversión, asumimos que es CURP (String)
            resenias =  self.repo.obtenerReseniaUsuario(dato)
        if resenias is None:
            return None
        
        reseniasMapeadas = []
        
        for data in resenias:
            calificadorObj = UsuarioCalificador(
                nombres=data['nombres'],
                apellidos=data['apellidos']
            )
            
            reniaObj = ReseniaOut(
                calificacion=int(data['calificacion']),
                comentario=data['comentario'],
                calificador=calificadorObj,
                fecha=data['fecha']
            )
            reseniasMapeadas.append(reniaObj)
        return reseniasMapeadas

    def obtenerReseniaResumen(self,curp : str):
        return self.repo.obtenerReseniaResumen(curp)
        