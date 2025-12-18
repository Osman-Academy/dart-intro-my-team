

import 'package:get_it/get_it.dart';
import '../../domain/repositories/task_repository.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../data/datasources/task_data_source.dart';
import '../../presentation/bloc/task_bloc.dart';

final getIt = GetIt.instance;

/// Initializes dependency injection for the app
void configureDependencies() {
  // Register Data Sources first
  getIt.registerLazySingleton<TaskDataSource>(
    () => MockTaskDataSource(),
  );

  // Register Repositories
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(getIt<TaskDataSource>()),
  );

  // Register BLoCs
  getIt.registerLazySingleton<TaskBloc>(
    () => TaskBloc(getIt<TaskRepository>()),
  );
}
