
from domain.entities.casa import Casa
from dataBase import DataBaseConexion
import mysql.connector

class RepoCasa:
    def conectarDB(self):
        return DataBaseConexion.obtenerConexion()
    
    def obtenerCasasRecintes(self,limit):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
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
            c.id_region,
            c.id_propietario,
            r.codigo_postal,
            r.estado,
            r.municipio,
            u.nombres,
            u.apellidos,
            u.fecha_registro,
            u.curp
            FROM Casas AS c
            JOIN Usuarios AS u 
            ON u.curp = c.id_propietario
            Join Regiones AS r
            ON c.id_region = r.codigo_postal
            ORDER BY id DESC
        """
        if limit > 0:
            sql  += f'LIMIT {limit};'
        else:
            sql+=";"
        try:
            cursor.execute(sql)
            casas = cursor.fetchall()
            conx.close()
            cursor.close()
            return casas
        except Exception as e:
            print(F"ERROR {e}")
    
    def obtenerCasasPopulares(self,limit):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
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
            c.id_region,
            c.id_propietario,
            r.codigo_postal,
            r.estado,
            r.municipio,
            u.nombres,
            u.apellidos,
            u.fecha_registro,
            u.curp
            FROM Casas AS c
            JOIN Usuarios AS u 
            ON u.curp = c.id_propietario
            Join Regiones AS r
            ON c.id_region = r.codigo_postal 
        """
        if limit > 0:
            sql  += f'LIMIT {limit};'
        else:
            sql+=";"
        try:
            cursor.execute(sql)
            casas = cursor.fetchall()
            conx.close()
            cursor.close()
            return casas
        except Exception as e:
            print(F"ERROR {e}")
            
    
    def existeCasa(self,id):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql = '''
            SELECT 1 FROM Casas Where id = %s;
        '''
        cursor.execute(sql,(id,))
        casa = cursor.fetchone()
        conx.close()
        cursor.close()
        return casa
    
    def casaMismaDireccion(self,calle,num,id_region):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql = '''
           SELECT 1 FROM Casas WHERE
           %s = calle && 
           %s= num_interior && 
           %s = id_region
           LIMIT 1;
        '''
        cursor.execute(sql,(calle,num,id_region))
        casa = cursor.fetchone()
        conx.close()
        cursor.close()
        return casa 
        
    
    def obtenerCasa(self,id):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
        sql = '''
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
            c.id_region,
            c.id_propietario,
            r.codigo_postal,
            r.estado,
            r.municipio,
            u.nombres,
            u.apellidos,
            u.fecha_registro,
            u.curp
            FROM Casas AS c
            JOIN Usuarios AS u 
            ON u.curp = c.id_propietario
            Join Regiones AS r
            ON c.id_region = r.codigo_postal
            WHERE c.id = %s;
        '''
        try:
            cursor.execute(sql,(id,))
            casa = cursor.fetchone()
            conx.close()
            cursor.close()
            return casa
        except Exception as e:
            print(F"ERROR {e}")
            
            
        
        
    
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
        cursor = conx.cursor(dictionary=True)
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
            c.id_region,
            c.id_propietario,
            r.codigo_postal,
            r.estado,
            r.municipio,
            u.nombres,
            u.apellidos,
            u.fecha_registro,
            u.curp
            FROM Casas AS c
            JOIN Usuarios AS u 
            ON u.curp = c.id_propietario
            Join Regiones AS r
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
        cursor = conx.cursor(dictionary=True)
        sql = """
            SELECT 
            c.id,
            c.titulo,
            c.cupo,
            c.tipo,
            c.imagen,
            c.cuartos,
            c.calle,
            c.id_region,
            c.id_propietario,
            c.num_interior,
            c.precio,
            r.codigo_postal,
            r.estado,
            r.municipio,
            u.nombres,
            u.apellidos,
            u.fecha_registro,
            u.curp
            FROM Casas AS c
            JOIN Usuarios AS u 
            ON u.curp = c.id_propietario
            Join Regiones AS r
            ON c.id_region = r.codigo_postal
            Where %s = c.tipo;
        """
        cursor.execute(sql,(filtro,))
        casas = cursor.fetchall()
        conx.close()
        cursor.close()
        return casas
    
    def obtenerCasasPorCuartos(self,filtro:str):
        simbolo = "="
        if(filtro == '4'):
            simbolo = ">="
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
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
            c.id_region,
            c.id_propietario,
            r.codigo_postal,
            r.estado,
            r.municipio,
            u.nombres,
            u.apellidos,
            u.fecha_registro,
            u.curp
            FROM Casas AS c
            JOIN Usuarios AS u 
            ON u.curp = c.id_propietario
            Join Regiones AS r
            ON c.id_region = r.codigo_postal
            Where c.cuartos 
        """+f"{simbolo}"+" %s"
        cursor.execute(sql,(filtro,))
        casas = cursor.fetchall()
        conx.close()
        cursor.close()
        return casas
    
    def obtenerCasas(self):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
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
            c.id_region,
            c.id_propietario,
            r.codigo_postal,
            r.estado,
            r.municipio,
            u.nombres,
            u.apellidos,
            u.fecha_registro,
            u.curp
            FROM Casas AS c
            JOIN Usuarios AS u 
            ON u.curp = c.id_propietario
            Join Regiones AS r
            ON c.id_region = r.codigo_postal;
        """
        cursor.execute(sql)
        casas = cursor.fetchall()
        conx.close()
        cursor.close()
        return casas
    
    def obtenerCasasCurp(self,curp: str):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
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
            c.id_region,
            r.codigo_postal,
            r.estado,
            r.municipio
            FROM Casas AS c
            Join Regiones AS r
            ON c.id_region = r.codigo_postal
            WHERE c.id_propietario = %s
        """
        cursor.execute(sql,(curp,))
        casas = cursor.fetchall()
        conx.close()
        cursor.close()
        return casas
    