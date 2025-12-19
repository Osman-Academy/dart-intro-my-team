import 'package:get_it/get_it.dart';
import '../../features/users/data/repositories/user_repository_impl.dart';
import '../../features/users/domain/repositories/user_repository.dart';
import '../../features/users/domain/usecases/get_users_usecase.dart';
import '../../features/users/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(),
  );

  // UseCase
  sl.registerLazySingleton(
    () => GetUsersUseCase(sl()),
  );

  // Bloc
  sl.registerFactory(
    () => UserBloc(sl()),
  );
}
