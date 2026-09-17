
import 'package:clock_store_app/core/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'admin@app.com' && password == '123456') {
      return const UserModel(id: '1', name: 'Admin', email: 'admin@app.com');
    }

    throw Exception('Invalid email or password');
  }
}
