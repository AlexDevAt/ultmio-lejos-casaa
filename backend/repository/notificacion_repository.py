
from domain.entities.notificacion import Notificacion
from dataBase import DataBaseConexion
import mysql.connector

class NotificacionRepository:
    def conectarDB(self):
        return DataBaseConexion.obtenerConexion()
    
    def save(self,noti: Notificacion):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
        sql ='''
            INSERT INTO notificaciones 
            (id_destinatario,id_emisor,tipo,fecha_envio,leido,mensaje) 
            VALUES(%s,%s,%s,%s,0,%s);
        '''
        try:
            cursor.execute(sql,(noti.id_destinatario,noti.id_emisor,noti.tipo,noti.fecha_envio,noti.mensaje,))
            id = cursor.lastrowid
            cursor.close()
            conx.commit()
            conx.close()
            return id
        except Exception as e:
            print(e)
        
        
    
    def obtenerNotificacionesNoLeidas(self,curp):
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
            ON id_emisor = u.curp
            WHERE id_destinatario = %s; 
        '''
        try:
            
            cursor.execute(sql,(curp,))
            notis = cursor.fetchall()
            conx.close()
            cursor.close()
            return notis
        except Exception as e:
            print(e)
        