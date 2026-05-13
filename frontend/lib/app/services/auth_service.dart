import 'package:lejos_de_casa_front/domain/repositories/auth_repository.dart';

class AuthService {
  AuthRepository repo;
  AuthService(this.repo);

  Future<String> login(String email, String pass) async {
    return await repo.login(email, pass);
  }
}
