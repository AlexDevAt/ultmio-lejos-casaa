import 'package:lejos_de_casa_front/domain/repositories/auth_repository.dart';
import 'package:lejos_de_casa_front/infrastructure/data/auth_data.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthData dataSource;
  AuthRepositoryImpl(this.dataSource);

  @override
  Future<String> login(String email, String password) async {
    return await dataSource.login(email, password);
  }
}
