import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../data/task_remote_data_source.dart';
import '../domain/task_repository.dart';          
import '../domain/task_repository_impl.dart';     

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => TaskRemoteDataSource(getIt()));
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(getIt()), 
  );
  
}