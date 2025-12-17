import 'package:dio/dio.dart';

class DioFactory {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: false,
        responseBody: false,
        error: true,
      ),
    );

    return dio;
  }
}
