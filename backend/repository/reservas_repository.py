import mysql.connector
from dataBase import  DataBaseConexion
from domain.entities.reservas import Reserva
class ReservarioRepository:
    def __init__(self):
        pass
    
    def conectarDB(self):
        return DataBaseConexion.obtenerConexion()
    
    def obtenerReservas(self,idComprador):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
        sql ='''
            SELECT r.id AS id_reserva,r.fecha_inicio,r.fecha_fin,r.estado AS estado_reserva,
            c.id  AS id_casa,c.cupo,c.tipo,c.imagen,c.cuartos,c.calle,c.num_interior,c.precio,c.titulo,
            u.codigo_postal,u.estado,u.municipio,
            p.curp AS propietario_curp,
            p.nombres AS propietario_nombre,
            p.apellidos AS propietario_apellidos,
            p.fecha_registro AS propietario_registro,
            co.curp AS comprador_curp,
            co.nombres AS comprador_nombre,
            co.apellidos AS comprador_apellidos,
            co.fecha_registro AS comprador_registro
            FROM reservas AS r 
            JOIN Casas AS c
            ON r.id_casa = c.id
            JOIN Regiones AS u
            ON c.id_region = u.codigo_postal
            JOIN Usuarios AS p
            ON c.id_propietario = p.curp
            JOIN Usuarios as co
            ON r.id_comprador = co.curp
            WHERE r.id_comprador = %s;
        '''
        cursor.execute(sql,(idComprador,))
        reservas = cursor.fetchall()
        cursor.close
        conx.close()
        return reservas
    
    
    def obtenerReservasCasa(self,casa):
        conx : mysql.connector.MySQLConnection = self.conectarDB()
        cursor = conx.cursor(dictionary=True)
        sql ='''
            SELECT r.id AS id_reserva,r.fecha_inicio,r.fecha_fin,r.estado AS estado_reserva,
            co.curp AS comprador_curp,
            co.nombres AS comprador_nombre,
            co.apellidos AS comprador_apellidos,
            co.fecha_registro AS comprador_registro
            FROM reservas AS r 
            JOIN Usuarios as co
            ON r.id_comprador = co.curp
            WHERE r.id_casa = %s;
        '''
        cursor.execute(sql,(casa,))
        reservas = cursor.fetchall()
        cursor.close
        conx.close()
        return reservas
    
    def crearReserva(self,reserva:Reserva):
       conx : mysql.connector.MySQLConnection = self.conectarDB()
       cursor = conx.cursor(dictionary=True)
       sql ='''
        INSERT INTO Reservas(fecha_inicio,fecha_fin,estado,id_casa,id_comprador)
        VALUES(%s,%s,%s,%s,%s)
       '''
       try:
           cursor.execute(sql,(
               reserva.fecha_inicio,
               reserva.fecha_fin,
               reserva.estado,
               reserva.idCasa,
               reserva.idComprador
           ))
           conx.commit()
           return reserva,cursor.lastrowid
       except Exception as e:
           conx.rollback()
           print(F"ERROR {e}")
           raise
       finally:
            cursor.close()
            conx.close() 
            
           
         