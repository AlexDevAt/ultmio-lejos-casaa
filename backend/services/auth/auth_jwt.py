import jwt
from fastapi import HTTPException,Depends,Header
SECRETKET = '123'
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
security_scheme = HTTPBearer()
class AuthJwt:    
    @staticmethod
    def createToken(user):
        token = jwt.encode(user,SECRETKET,algorithm='HS256')
        return token
    @staticmethod
    def validarToken(credenciales: HTTPAuthorizationCredentials = Depends(security_scheme)):
        token = credenciales.credentials
        payload = jwt.decode(token,SECRETKET,algorithms=['HS256'])
        return payload
        # return payload