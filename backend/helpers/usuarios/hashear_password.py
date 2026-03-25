from passlib.hash import bcrypt

class HashPass:
     @classmethod
     def generarHash(self, password: str):
         return bcrypt.hash(password)
     @classmethod
     def verificarHash(self,password,hash):
         return bcrypt.verify(password,hash)
         


