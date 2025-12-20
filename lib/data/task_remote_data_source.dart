import 'package:dio/dio.dart';

class TaskRemoteDataSource {
  final Dio dio;

  TaskRemoteDataSource(this.dio);

  Future<List<dynamic>> getTasks() async {
    final response = await dio.get("http://127.0.0.1:3000/tasks");
    return response.data as List<dynamic>;
  }
  Future<void> addTask(Map<String, dynamic> task) async {
    await dio.post("http://127.0.0.1:3000/tasks", data: task);
  }

  
}


