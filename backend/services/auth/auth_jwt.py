import jwt
from fastapi import HTTPException,Depends,Header
SECRETKET = '123'
from fastapi.security import OAuth2PasswordBearer

class AuthJwt:    
    @staticmethod
    def createToken(user):
        token = jwt.encode(user,SECRETKET,algorithm='HS256')
        return token
    @staticmethod
    def validarToken(authorization: str = Header(None)):
        print(authorization)
        token = authorization.replace("Bearer ", "")
        payload = jwt.decode(token,SECRETKET,algorithms=['HS256'])
        return payload
        # return payload