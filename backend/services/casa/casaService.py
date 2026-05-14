from repository.casa_repository import RepoCasa
from schemas.usuario.usuarioDTO import PropietarioCasaBasico
from schemas.casa.Casa_DTO import CasaOut
from helpers.casas.casaTipo import TipoCasa
from domain.entities.casa import Casa
from excepciones.casas.excepciones_casa import *
from schemas.region.regionDTO import RegionoOUT


class CasaService:
    def __init__(self, repo):
        self.repo: RepoCasa = repo
        
    def _CasaMismaDireccion(self,calle,num,cp) -> bool:
        return self.repo.casaMismaDireccion(calle,num,cp)
    
    def _existeCasa(self,id) -> bool:
        return self.repo.existeCasa(id)
        

    def crearCasa(self,dto:Casa) -> Casa:
        if(self._CasaMismaDireccion(dto.calle,dto.num_interior,dto.idRegion) is not None):
            raise casaConMismaDir()
        
        
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
    
    
    def obtenerCasa(self,id) -> Casa:
        if(self._existeCasa(id) is None):
            raise NoExisteCasa()
        casa = self.repo.obtenerCasa(id)
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
        return casaOut
        
    def obtenerCasas(self, filtro: str = None, tipoFiltro=None) -> list:
        if filtro is not None:
            if tipoFiltro is not None and tipoFiltro == 'codigo_postal':
                casas = self.repo.obtenerCasasPorTipoCodigoPostal(filtro)
            elif  tipoFiltro is not None and tipoFiltro == 'cantidad de cuartos':
                casas = self.repo.obtenerCasasPorCuartos(filtro)
            elif  tipoFiltro is not None and tipoFiltro == 'tipo de casa':
                casas = self.repo.obtenerCasasPorTipo(filtro)
        else:
            casas = self.repo.obtenerCasas()
        data = []
        for casa in casas:
            propietario = PropietarioCasaBasico(
                nombres=casa['nombres'],
                apellidos=casa['apellidos'],
                fecha_registro=casa['fecha_registro'],
                curp=casa['curp']
            )
            
            region = RegionoOUT(
                codigo_postal=casa['codigo_postal'],
                estado=casa['estado'],
                municipio=casa['municipio'])

            casaOut = CasaOut(
                id=casa['id'],
                titulo=casa['titulo'],
                cupo=int(casa['cupo']),
                tipo=TipoCasa.convertirTipoCasa(casa['tipo']),
                imagen=casa['imagen'],
                cuartos=casa['cuartos'],
                calle=casa['calle'],
                num_interior=casa['num_interior'],
                precio=float(casa['precio']),
                region=region,
                propietario=propietario
            )

            data.append(casaOut)

        return data
