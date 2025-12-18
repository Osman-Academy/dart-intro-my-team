import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.response?.statusCode) {
      case 400:
        print("Bad Request");
        break;
      case 404:
        print("Resource Not Found (404)");
        break;
      case 500:
        print("Internal Server Error");
        break;
    }
    super.onError(err, handler);
  }
}