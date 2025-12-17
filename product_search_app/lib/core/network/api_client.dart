import 'package:dio/dio.dart';

class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get(path, queryParameters: queryParameters);
  }
}
