from config.env_config import EnvConfig
import mysql.connector
class DataBaseConexion:
    
    @classmethod
    def obtenerConexion(self):
        try:
            return mysql.connector.connect(
            host = 'localhost',
            port = '3306',
            user = 'root',
            password = 'Alexismau123.',
            database = 'lejos_de_casa'
        )
        except:
            print("ERROR EN LA BASE DE DATOS ")