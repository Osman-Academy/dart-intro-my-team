import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';
import '../utils/constants.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // Регистрируем SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  
  // Регистрируем Dio
  final dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));
  
  
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: (obj) {
      print(obj);
    },
  ));
  
  getIt.registerSingleton<Dio>(dio);
  
  // Регистрируем ApiClient
  getIt.registerSingleton<ApiClient>(ApiClient(dio));
  
  // Инициализируем остальные зависимости через injectable
  getIt.init();
}