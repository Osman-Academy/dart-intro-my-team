import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void configureDependencies(){
  getIt.registerLazySingleton<Dio>(
      () => Dio(BaseOptions(
        baseUrl: 'https://potterapi-fedeperin.vercel.app',
      )),
  );
}