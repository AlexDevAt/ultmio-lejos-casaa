from repository.casa_repository import RepoCasa
from schemas.usuario.usuarioBase import PropietarioCasaBasico
from schemas.casa.Casa_DTO import *
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
                id_propietario=casa['id_propietario'],
                id_region=casa['id_region'],
                region=region,
                propietario=propietario
            )
        return casaOut
        
    def obtenerCasas(self,filtroActivo  : bool = False, filtro: str = None, tipoFiltro=None,limit = int,limitActivo = False) -> list:
        if filtroActivo :
            if  tipoFiltro == 'codigo_postal':
                casas = self.repo.obtenerCasasPorTipoCodigoPostal(filtro)
            elif  tipoFiltro == 'cantidad de cuartos':
                casas = self.repo.obtenerCasasPorCuartos(filtro)
            elif  tipoFiltro == 'tipo de casa':
                casas = self.repo.obtenerCasasPorTipo(filtro)
            elif  tipoFiltro == 'populares':
                casas = self.repo.obtenerCasasPopulares(limit)
            elif tipoFiltro == 'recientes':
                casas = self.repo.obtenerCasasRecintes(limit)
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
                id_propietario=casa['id_propietario'],
                id_region=casa['id_region'],
                region=region,
                propietario=propietario
            )
            data.append(casaOut)
        return data
    
    def obtenerCasasCurp(self, curp:str) -> list:
        casas = self.repo.obtenerCasasCurp(curp)
        data = []
        for casa in casas:            
            region = RegionoOUT(
                codigo_postal=casa['codigo_postal'],
                estado=casa['estado'],
                municipio=casa['municipio'])
            casaOut = CasaOutPropietario(
                id=casa['id'],
                titulo=casa['titulo'],
                cupo=int(casa['cupo']),
                tipo=TipoCasa.convertirTipoCasa(casa['tipo']),
                imagen=casa['imagen'],
                cuartos=casa['cuartos'],
                calle=casa['calle'],
                num_interior=casa['num_interior'],
                precio=float(casa['precio']),
                id_region=casa['id_region'],
                region=region,
            )
            
            data.append(casaOut)
        return data
