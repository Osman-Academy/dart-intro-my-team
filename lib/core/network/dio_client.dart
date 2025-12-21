import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;
  DioClient({Dio? dio})
      : dio = dio ??
      Dio(BaseOptions(
        baseUrl: 'http://localhost:3000',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ));
}
