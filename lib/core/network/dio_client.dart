import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient({Dio? dioClient}) : dio = dioClient ?? Dio();

  Future<Response> get(String url) async {
    try {
      final response = await dio.get(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
