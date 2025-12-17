import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_finall_project/data/datasources/task_remote_datasource.dart';
import 'package:flutter_application_finall_project/data/repositories/task_repository_impl.dart';
import 'package:flutter_application_finall_project/domain/repositories/task_repository.dart';
import 'package:flutter_application_finall_project/domain/usecases/get_tasks.dart';
import 'package:flutter_application_finall_project/domain/usecases/add_task.dart';
import 'package:flutter_application_finall_project/domain/usecases/update_task.dart';
import 'package:flutter_application_finall_project/domain/usecases/delete_task.dart';

final GetIt sl = GetIt.instance;

/// Register all dependencies for Dependency Injection.
/// Call this at app startup before runApp().
Future<void> init() async {
  // External
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Data sources
  sl.registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteDataSource(client: sl<http.Client>()));

  // Repositories
  sl.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(remoteDataSource: sl<TaskRemoteDataSource>()));

  // Use cases
  sl.registerLazySingleton<GetTasks>(() => GetTasks(sl<TaskRepository>()));
  sl.registerLazySingleton<AddTask>(() => AddTask(sl<TaskRepository>()));
  sl.registerLazySingleton<UpdateTask>(() => UpdateTask(sl<TaskRepository>()));
  sl.registerLazySingleton<DeleteTask>(() => DeleteTask(sl<TaskRepository>()));
}
