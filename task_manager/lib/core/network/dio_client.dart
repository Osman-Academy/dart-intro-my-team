import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;
  DioClient(this.dio);

  Future<Response<T>> get<T>(String path) => dio.get<T>(path);

  Future<Response<T>> post<T>(String path, {Object? data}) =>
      dio.post<T>(path, data: data);

  Future<Response<T>> put<T>(String path, {Object? data}) =>
      dio.put<T>(path, data: data);

  Future<Response<T>> patch<T>(String path, {Object? data}) =>
      dio.patch(path, data: data);

  Future<Response<T>> delete<T>(String path) => dio.delete<T>(path);
}
