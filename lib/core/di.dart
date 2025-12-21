import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../data/user_repository.dart';
import '../presentation/bloc/user_bloc.dart';

final getIt = GetIt.instance;

void setupDI() {

  getIt.registerLazySingleton<Dio>(() => Dio());


  getIt.registerLazySingleton<UserRepository>(
        () => UserRepository(getIt<Dio>()),
  );


  getIt.registerFactory<UserBloc>(
        () => UserBloc(getIt<UserRepository>()),
  );
}
