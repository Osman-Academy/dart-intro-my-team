import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../data/datasources/task_remote_data_source.dart';
import '../data/repositories/task_repository_impl.dart';
import '../domain/repositories/task_repository.dart';

final GetIt getIt = GetIt.instance;

/// Register app dependencies. Call this early in `main()`.
void setupInjection() {
  // Register a single shared http.Client
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  // Remote data source
  getIt.registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteDataSource(client: getIt<http.Client>()));

  // Repository
  getIt.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(remoteDataSource: getIt<TaskRemoteDataSource>()));
}
