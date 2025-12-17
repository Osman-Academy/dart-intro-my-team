import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager/features/task_manager/data/repositories/task_repository_impl.dart';

import 'core/network/dio_client.dart';
import 'core/utils/constants.dart';
import 'features/task_manager/data/datasource/task_remote_datasource.dart';
import 'features/task_manager/domain/repositories/task_repository.dart';
import 'features/task_manager/domain/usecases/get_tasks.dart';
import 'features/task_manager/domain/usecases/search_tasks.dart';
import 'features/task_manager/presentation/bloc/task_bloc.dart';
import 'features/task_manager/domain/usecases/add_task.dart';
import 'features/task_manager/domain/usecases/update_task.dart';
import 'features/task_manager/domain/usecases/delete_task.dart';
import 'features/task_manager/domain/usecases/toggle_completed.dart';


final sl = GetIt.instance;

void initDI() {
  // external
  sl.registerLazySingleton<Dio>(() {
    return Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
  });

  sl.registerLazySingleton(() => DioClient(sl<Dio>()));

  // data
  sl.registerLazySingleton<TaskRemoteDatasource>(
    () => TaskRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(sl()),
  );

  // domain
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => SearchTasks(sl()));



  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));
  sl.registerLazySingleton(() => ToggleCompleted(sl()));
  
  // presentation
sl.registerFactory(() => TaskBloc(
        getTasks: sl(),
        searchTasks: sl(),
        addTask: sl(),
        updateTask: sl(),
        deleteTask: sl(),
        toggleCompleted: sl(),
      ));


}
