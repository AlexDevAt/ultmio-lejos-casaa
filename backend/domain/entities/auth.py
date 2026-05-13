

class Auth:
    def __init__(self,token:str,tokenType:str,expire:int,user):
        self.token = token
        self.tokenType = tokenType
        self.expire = expire
        self.user = user
