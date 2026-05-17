from fastapi import FastAPI, APIRouter, Request, WebSocket, WebSocketDisconnect
from fastapi.templating import Jinja2Templates
from services.webSocket_config.configSocket import ConnectionManagerNotif 
from providers import webSocket 

router = APIRouter()
@router.websocket("/notificacion/{id}")
async def websocket_endpoint(webSocketUri: WebSocket,id : str):
    await webSocket.conncet(id,webSocketUri)
    try:
        while True:
            data = await webSocketUri.receive_text()
            await webSocket.enviarNotificacion(data,webSocketUri)
            await webSocket.broadcast(f'El usario dice {data} ',)
    except WebSocketDisconnect:

        webSocket.disconnect(id,webSocket)