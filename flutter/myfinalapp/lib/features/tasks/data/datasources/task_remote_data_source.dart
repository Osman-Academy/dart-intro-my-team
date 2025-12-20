import 'package:dio/dio.dart';
import '../models/task_dto.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskDto>> getTasks();
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Dio dio;

  TaskRemoteDataSourceImpl(this.dio);

  @override
  Future<List<TaskDto>> getTasks() async {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/todos',
    );

    return (response.data as List).map((e) => TaskDto.fromJson(e)).toList();
  }
}
