from fastapi import FastAPI, APIRouter, Request, WebSocket, WebSocketDisconnect
from fastapi.templating import Jinja2Templates
from services.webSocket_config.configSocket import ConnectionManagerNotif 

manager = ConnectionManagerNotif()
router = APIRouter()
@router.websocket("/notificacion/{id}")
async def websocket_endpoint(webSocket: WebSocket,id : str):
    await manager.conncet(id,webSocket)
    try:
        while True:
            data = await webSocket.receive_text()
            await manager.enviarNotificacion(data,webSocket)
            await manager.broadcast(f'El usario dice {data} ',)
    except WebSocketDisconnect:
        manager.disconnect(id,webSocket)