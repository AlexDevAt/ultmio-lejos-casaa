from config.env_config import EnvConfig
import mysql.connector
class DataBaseConexion:
    
    @classmethod
    def obtenerConexion(self):
        try:
            return mysql.connector.connect(
            host = EnvConfig.DB_HOST,
            port = EnvConfig.DB_PORT,
            user = EnvConfig.DB_USER,
            password = EnvConfig.DB_PASSWORD,
            database = EnvConfig.DB_NAME
        )
        except:
            print("ERROR EN LA BASE DE DATOS ")