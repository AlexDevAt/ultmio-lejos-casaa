from dataBase import DataBaseConexion
import mysql.connector

class ReseniaRepository:
    def conectarDB(self):
        return DataBaseConexion.obtenerConexion()
    
    def obtenerReseniaCasa(self,idCasa):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
        sql = '''
            SELECT id,calificacion,comentario,id_casa,u.nombres,u.apellidos,fecha
            FROM reseniascasas 
            JOIN Usuarios AS u 
            ON id_calificador = u.curp
            WHERE id_casa = %s;
        '''
        cursor.execute(sql,(idCasa,))
        resenias = cursor.fetchall()
        cursor.close
        conx.close()
        return resenias
    
    def obtenerReseniaUsuario(self,curp):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
        sql = '''
            SELECT id,calificacion,comentario,u.nombres,u.apellidos,fecha
            FROM reseniasUsuario
            JOIN Usuarios AS u 
            ON id_calificador = u.curp
            WHERE id_Usuario = %s;
            
        '''
        cursor.execute(sql,(curp,))
        resenias = cursor.fetchall()
        cursor.close
        conx.close()
        return resenias
        
        