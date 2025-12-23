import 'package:get_it/get_it.dart';
import '../domain/repositories/user_repository.dart';
import '../data/repositories/in_memory_user_repository.dart';

final getIt = GetIt.instance;

Future<void> initDI() async {
  // Register repository
  getIt.registerLazySingleton<UserRepository>(() => InMemoryUserRepository());
}
