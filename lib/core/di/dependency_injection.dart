import 'package:clock_store_app/core/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:clock_store_app/core/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clock_store_app/core/features/auth/domain/repositories/auth_repository.dart';
import 'package:clock_store_app/core/features/auth/domain/usecases/login.dart';
import 'package:clock_store_app/core/features/auth/presentation/cubits/auth_cubits.dart';
import 'package:get_it/get_it.dart';


final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // -------------------------
  // Data Sources
  // -------------------------

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // -------------------------
  // Repositories
  // -------------------------

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );

  // -------------------------
  // Use Cases
  // -------------------------

  getIt.registerLazySingleton<Login>(() => Login(getIt<AuthRepository>()));

  // -------------------------
  // Cubits
  // -------------------------

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(loginUseCase: getIt<Login>()),
  );
}
