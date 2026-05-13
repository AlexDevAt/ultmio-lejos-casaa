from dataBase import DataBaseConexion
import mysql.connector

class AuthRepository:
    def conectarDB(self):
        return DataBaseConexion.obtenerConexion()
    
    def obtenerDatosUsuario(self,correo):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
        sql = '''
            SELECT curp,nombres,correo FROM Usuarios WHERE correo =%s;
        '''
        cursor.execute(sql,(correo,))
        usuario = cursor.fetchone()
        cursor.close()
        conx.close()
        return usuario
    
    def obtenerPassPorEmail(self,correo) -> str:
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql =  '''
            SELECT contrasenia FROM Usuarios WHERE correo =%s LIMIT 1;
        '''
        cursor.execute(sql,(correo,))
        contrasenia = cursor.fetchone()
        conx.close()
        cursor.close()
        return contrasenia
    
    def verificarPassword(self,correo:str,passw:str):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql = '''
            SELECT 1 FROM Usuarios WHERE correo =%s && 
        '''
        
    
    def usuarioExiste(self, correo: str) -> bool:
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor()
        sql = '''
            SELECT curp,nombres,correo FROM Usuarios 
            WHERE correo = %s LIMIT 1;
        '''
        cursor.execute(sql,(correo,))
        existe = cursor.fetchone()
        conx.close()
        cursor.close()
        return existe is not None