from repository.casa_repository import RepoCasa
from schemas.usuario.usuarioDTO import PropietarioCasaBasico
from schemas.casa.Casa_DTO import CasaOut
from helpers.casas.casaTipo import TipoCasa
from domain.entities.casa import Casa


class CasaService:
    def __init__(self, repo):
        self.repo: RepoCasa = repo
        

    def crearCasa(self,dto:Casa):
        casaNew = Casa(
            id = None,
            titulo=dto.titulo,
            cupo = dto.cupo,
            tipo = dto.tipo,
            imagen = dto.imagen,
            cuartos = dto.cuartos,
            calle = dto.calle,
            num_interior= dto.num_interior,
            precio=dto.precio,
            idRegion=dto.idRegion,
            id_propietario=dto.id_propietario,
        )
        casa = self.repo.crearCasa(casaNew)
        return casa

    def obtenerCasas(self, filtro: str = None, tipoFiltro=None):
        if filtro is not None:
            if tipoFiltro is not None and tipoFiltro == 'codigo_postal':
                casas = self.repo.obtenerCasasPorTipoCodigoPostal(filtro)
            else:
                casas = self.repo.obtenerCasasPorTipo(filtro)
        else:
            casas = self.repo.obtenerCasas()

        data = []

        for casa in casas:
            propietario = PropietarioCasaBasico(
                nombres=casa[10],
                apellidos=casa[11],
                fecha_registro=casa[12],
                curp=casa[13]
            )

            casaOut = CasaOut(
                id=casa[0],
                titulo=casa[1],
                cupo=casa[2],
                tipo=TipoCasa.convertirTipoCasa(casa[3]),
                imagen=casa[4],
                cuartos=casa[5],
                calle=casa[6],
                num_interior=casa[7],
                precio=float(casa[8]),
                idRegion=casa[9],
                propietario=propietario
            )

            data.append(casaOut)

        return data
