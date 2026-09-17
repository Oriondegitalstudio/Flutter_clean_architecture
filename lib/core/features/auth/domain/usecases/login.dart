
import 'package:clock_store_app/core/features/auth/domain/entities/user.dart';
import 'package:clock_store_app/core/features/auth/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<User> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
