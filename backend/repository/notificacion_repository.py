
from domain.entities.notificacion import Notificacion
from dataBase import DataBaseConexion
import mysql.connector

class NotificacionRepository:
    def conectarDB(self):
        return DataBaseConexion.obtenerConexion()
    
    def obtenerNotificacionesNoLeidas(self):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
        
        sql = '''
            SELECT 
            id_notificacion,
            id_destinatario,
            id_emisor,
            tipo,
            fecha_envio,
            leido,
            mensaje,
            u.nombres AS nombre_emisor,
            u.apellidos AS apellidos_emisor
            FROM notificaciones
            LEFT JOIN Usuarios AS u 
            ON id_emisor = u.curp; 
        '''
        try:
            
            cursor.execute(sql)
            notis = cursor.fetchall()
            conx.close()
            cursor.close()
            return notis
        except Exception as e:
            print(e)
        