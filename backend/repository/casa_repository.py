
from domain.entities.casa import Casa
from dataBase import DataBaseConexion
import mysql.connector

class RepoCasa:
    def conectarDB(self):
        return DataBaseConexion.obtenerConexion()
    
    def crearCasa(self,casa:Casa):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql = '''
        INSERT INTO Casas (cupo,tipo,imagen,cuartos,calle,num_interior,id_region,id_propietario,precio,titulo) 
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
        '''
        try:
            cursor.execute(sql,(
                casa.cupo,
                casa.tipo,
                casa.imagen,
                casa.cuartos,
                casa.calle,
                casa.num_interior,
                casa.idRegion,
                casa.id_propietario,
                casa.precio,
                casa.titulo
            )) 
            conx.commit()
            conx.close()
            return casa
        except Exception as e:
            conx.rollback()
            print(F"ERROR {e}")
            raise
        finally:
            cursor.close()
            conx.close() 


    
    def obtenerCasasPorTipoCodigoPostal(self,filtro:str):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql = """
            SELECT 
            c.id,
            c.titulo,
            c.cupo,
            c.tipo,
            c.imagen,
            c.cuartos,
            c.calle,
            c.num_interior,
            c.precio,
            c.id_Region,
            u.nombres,
            u.apellidos,
            u.fecha_registro,
            u.curp
            FROM Casas AS c
            JOIN Usuarios AS u 
            ON u.curp = c.id_propietario
            JOIN Regiones as r 
            ON c.id_region = r.codigo_postal
            WHERE %s = c.id_region;
        """
        cursor.execute(sql,(filtro,))
        casas = cursor.fetchall()
        conx.close()
        cursor.close()
        return casas
    
    def obtenerCasasPorTipo(self,filtro:str):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql = """
            SELECT 
            c.id,
            c.titulo,
            c.cupo,
            c.tipo,
            c.imagen,
            c.cuartos,
            c.calle,
            c.num_interior,
            c.precio,
            c.id_Region,
            u.nombres,
            u.apellidos,
            u.fecha_registro,
            u.curp
            FROM Casas AS c
            JOIN Usuarios AS u 
            ON u.curp = c.id_propietario
            Where %s = c.tipo;
        """
        cursor.execute(sql,(filtro,))
        casas = cursor.fetchall()
        conx.close()
        cursor.close()
        return casas
    
    def obtenerCasas(self):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql = """
            SELECT 
            c.id,
            c.titulo,
            c.cupo,
            c.tipo,
            c.imagen,
            c.cuartos,
            c.calle,
            c.num_interior,
            c.precio,
            c.id_Region,
            u.nombres,
            u.apellidos,
            u.fecha_registro,
            u.curp
            FROM Casas AS c
            JOIN Usuarios AS u 
            ON u.curp = c.id_propietario;
        """
        cursor.execute(sql)
        casas = cursor.fetchall()
        conx.close()
        cursor.close()
        return casas
    