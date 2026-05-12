import jwt
SECRETKET = '123'
class AuthJwt:
    def __init__(self):
        pass
    
    @classmethod
    def createToken(self,user):
        token = jwt.encode(user,SECRETKET,algorithm='HS256')
        return token
    @classmethod
    def desencodeToken(self,token):
        payload = jwt.decode(token,SECRETKET,algorithms=['HS256'])
        return payload