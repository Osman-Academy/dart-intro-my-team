import '../../models/task_model.dart';
import 'api_client.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> fetchTasks();
  Future<TaskModel> createTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task);
  Future<TaskModel> moveTask(String taskId, String status);
  Future<TaskModel> assignTask(String taskId, String userId);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final ApiClient client;
  TaskRemoteDataSourceImpl(this.client);

  @override
  Future<List<TaskModel>> fetchTasks() async {
    final response = await client.get('/tasks');
    if (response == null) return [];
    return (response as List<dynamic>).map((e) => TaskModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    final response = await client.post('/tasks', task.toJson());
    return TaskModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    final response = await client.put('/tasks/${task.id}', task.toJson());
    return TaskModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<TaskModel> moveTask(String taskId, String status) async {
    final response = await client.put('/tasks/$taskId/move', {'status': status});
    return TaskModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<TaskModel> assignTask(String taskId, String userId) async {
    final response = await client.put('/tasks/$taskId/assign', {'userId': userId});
    return TaskModel.fromJson(response as Map<String, dynamic>);
  }
}
