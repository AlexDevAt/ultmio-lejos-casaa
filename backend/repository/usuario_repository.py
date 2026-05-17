
from domain.entities.usuario import Usuario
from dataBase import DataBaseConexion
import mysql.connector

class RepoUsuario:    
    def conectarDB(self):
        return DataBaseConexion.obtenerConexion()
    
    
    def usuarioExiste(self,curp: str) -> bool:
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql = "SELECT 1 FROM Usuarios WHERE curp = %s LIMIT 1"
        cursor.execute(sql,(curp,))
        existe = cursor.fetchone()
        conx.close()
        cursor.close()
        return existe is not None
    
    def borrarUsuario(self,curp:str):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql = 'DELETE FROM Usuarios WHERE curp = %s'
        cursor.execute(sql,(curp,))
        conx.commit()
        conx.close()
        cursor.close()
        
    
        
    def telefonoExiste(self,telefono: str) -> bool:
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql = "SELECT 1 FROM Usuarios WHERE telefono = %s LIMIT 1;"
        cursor.execute(sql,(telefono,))
        existe = cursor.fetchone()
        conx.close()
        cursor.close()
        return existe is not None
    
    def obtenerUsuarios(self):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
        sql = 'SELECT * FROM Usuarios;'
        cursor.execute(sql)
        usuarios = cursor.fetchall()
        conx.close()
        cursor.close()
        return usuarios
    
    def actualizarUsuario(self,curp,data: dict):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
        campos = []
        valores = []

        for clave, valor in data.items():
            campos.append(f"{clave} = %s")
            valores.append(valor)

        valores.append(curp)

        sql = f"""
        UPDATE Usuarios
        SET {', '.join(campos)}
        WHERE curp = %s
        """

        cursor.execute(sql, valores)
        conx.commit()
        
        

    def obtenerUsuarioCurp(self,curp: str) -> dict:
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
        sql = 'SELECT * FROM Usuarios WHERE curp = %s LIMIT 1;'
        cursor.execute(sql,(curp,))
        usuario = cursor.fetchone()
        conx.close()
        cursor.close()
        return usuario
    
    def crearUsuario(self,usuario: Usuario):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        print(usuario.municipio)
        insert = """
        INSERT INTO Usuarios(
            curp, nombres, apellidos,correo,
            telefono,rol,fecha_registro,
            calle,num_interior,
            codigo_postal,ciudad,municipio,contrasenia)
        VALUES(%s,%s,%s,%s,%s,%s,NOW(),%s,%s,%s,%s,%s,%s)
        """
        try:
            cursor.execute(insert,(
            usuario.curp,
            usuario.nombres,
            usuario.apellidos,
            usuario.correo,
            usuario.telefono,
            usuario.rol,
            usuario.calle,
            usuario.num_interior,
            usuario.codigo_postal,
            usuario.ciudad,
            usuario.municipio,
            usuario.contrasenia
            ))
            conx.commit()
            return usuario
        except Exception as e:
            conx.rollback()
            print(F"ERROR {e}")
            raise
        finally:
            cursor.close()
            conx.close() 
            
    def correoExistente(self,correo) -> bool:
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql =  '''
            SELECT 1 FROM Usuarios WHERE correo =%s LIMIT 1;
        '''
        cursor.execute(sql,(correo,))
        existe = cursor.fetchone()
        cursor.close()
        return existe is not None
