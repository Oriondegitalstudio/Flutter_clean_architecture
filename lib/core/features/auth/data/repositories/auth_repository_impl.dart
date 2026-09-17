

import 'package:clock_store_app/core/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:clock_store_app/core/features/auth/domain/entities/user.dart';
import 'package:clock_store_app/core/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login({required String email, required String password}) async {
    final userModel = await remoteDataSource.login(
      email: email,
      password: password,
    );

    return userModel.toEntity();
  }
}
