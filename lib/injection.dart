import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'presentation/bloc/student_bloc.dart';
import 'data/datasources/student_remote_data_source.dart';
import 'data/repositories/student_repository_impl.dart';
import 'domain/repositories/student_repository.dart';
import 'domain/usecases/get_students.dart';

final sl = GetIt.instance;

Future<void> init({String? baseUrl}) async {
  sl.registerLazySingleton<http.Client>(() => http.Client());

  sl.registerLazySingleton<StudentRemoteDataSource>(
    () => StudentRemoteDataSource(
      client: sl(),
      baseUrl: baseUrl ?? 'https://example.com/api',
    ),
  );

  sl.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<GetStudentsUseCase>(() => GetStudentsUseCase(sl()));

  sl.registerFactory(() => StudentBloc(getStudents: sl()));
}