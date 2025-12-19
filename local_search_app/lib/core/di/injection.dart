import 'package:get_it/get_it.dart';
import '../../features/users/data/repositories/user_repository_impl.dart';
import '../../features/users/domain/repositories/user_repository.dart';
import '../../features/users/domain/usecases/search_users_usecase.dart';
import '../../features/users/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(),
  );

  sl.registerLazySingleton(
    () => SearchUsersUseCase(sl()),
  );

  sl.registerFactory(
    () => UserBloc(sl()),
  );
}
