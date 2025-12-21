import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/tasks/data/datasources/task_remote_data_source.dart';
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';
import '../../features/tasks/domain/usecases/add_task_usecase.dart';
import '../../features/tasks/domain/usecases/delete_task_usecase.dart';
import '../../features/tasks/domain/usecases/get_tasks_usecase.dart';
import '../../features/tasks/domain/usecases/update_task_usecase.dart';
import '../../features/tasks/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // -----------------------------
  // BLoC
  // -----------------------------
  sl.registerFactory(
    () => TaskBloc(
      getTasks: sl(),
      addTask: sl(),
      updateTask: sl(),
      deleteTask: sl(),
    ),
  );

  // -----------------------------
  // Use cases
  // -----------------------------
  sl.registerLazySingleton(() => GetTasksUseCase(sl()));
  sl.registerLazySingleton(() => AddTaskUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));

  // -----------------------------
  // Repository
  // -----------------------------
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

  // -----------------------------
  // Data sources
  // -----------------------------
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(sl()),
  );

  // -----------------------------
  // External
  // -----------------------------
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://your-api-url.com', // 🔴 CHANGE THIS
        headers: {'Content-Type': 'application/json'},
      ),
    ),
  );
}
