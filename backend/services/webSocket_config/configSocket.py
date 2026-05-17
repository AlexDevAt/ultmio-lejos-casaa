from fastapi import WebSocket, WebSocketDisconnect


class ConnectionManagerNotif:
    def __init__(self):
        self.conexiones = {}
    
    async def conncet(self,id : str,webSocket : WebSocket):
        await webSocket.accept()
        self.conexiones[id] = webSocket 
        print(f'Conexion exitosa usuario guardado en la conexion. ID usuario : {id} ')
        
    async def enviarNotificacion(self, message: str, websocket: WebSocket):
        await websocket.send_text(message)
        
    def disconnect(self,id:str,webSocket : WebSocket):
        if id in self.conexiones:
            del self.conexiones[id]
            print(f'Usuario {id} desconectado')
    
    async def emitirHaciaUsuario(self,idUsuario,evento,data):
        print(self.conexiones.__str__())
        print(idUsuario)
        webSocketUsuario : WebSocket = self.conexiones.get(idUsuario)
        if webSocketUsuario:
            print('ENVIANDO')
            await webSocketUsuario.send_json({
                "event" : evento,
                "data":data
            })
        
            
    async def broadcast(self, message: str):
        for connection in self.conexiones.values():
            await connection.send_text(message)
        
    
    
    