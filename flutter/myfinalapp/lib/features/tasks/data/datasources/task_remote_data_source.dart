import 'package:dio/dio.dart';

import '../models/task_dto.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskDto>> getTasks();
  Future<TaskDto> addTask(TaskDto task);
  Future<TaskDto> updateTask(TaskDto task);
  Future<void> deleteTask(int id);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Dio dio;

  TaskRemoteDataSourceImpl(this.dio);

  @override
  Future<List<TaskDto>> getTasks() async {
    final response = await dio.get('/tasks');
    return (response.data as List)
        .map((json) => TaskDto.fromJson(json))
        .toList();
  }

  @override
  Future<TaskDto> addTask(TaskDto task) async {
    final response = await dio.post('/tasks', data: task.toJson());
    return TaskDto.fromJson(response.data);
  }

  @override
  Future<TaskDto> updateTask(TaskDto task) async {
    final response = await dio.put('/tasks/${task.id}', data: task.toJson());
    return TaskDto.fromJson(response.data);
  }

  @override
  Future<void> deleteTask(int id) async {
    await dio.delete('/tasks/$id');
  }
}
