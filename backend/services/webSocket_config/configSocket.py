from fastapi import WebSocket, WebSocketDisconnect


class ConnectionManagerNotif:
    def __init__(self):
        self.conexiones = {}
    
    async def conncet(self,id : str,webSocket : WebSocket):
        await webSocket.accept()
        self.conexiones[id] = webSocket 
        print(f'Conexion exitosa usuario guardado en la conexion : {id} ')
    def disconnect(self,id:str,webSocket : WebSocket):
        if id in self.conexiones:
            del self.conexiones[id]
            print(f'Usuario {id} desconectado')
        
    
    
    