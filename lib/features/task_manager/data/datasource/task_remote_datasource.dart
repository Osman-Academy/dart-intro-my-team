import '../../../../core/network/dio_client.dart';
import '../../../../core/utils/constants.dart';
import '../models/task_model.dart';

abstract class TaskRemoteDatasource {
  Future<List<TaskModel>> fetchTasks();
  Future<TaskModel> createTask(String title);
  Future<TaskModel> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
  Future<TaskModel> patchCompleted(String id, bool completed);
}

class TaskRemoteDatasourceImpl implements TaskRemoteDatasource {
  final DioClient client;
  TaskRemoteDatasourceImpl(this.client);

  @override
  Future<List<TaskModel>> fetchTasks() async {
    final res = await client.get(ApiConstants.tasksPath);
    final data = res.data as List<dynamic>;
    return data
        .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TaskModel> createTask(String title) async {
    final res = await client.post(ApiConstants.tasksPath, data: {
      "title": title,
      "completed": false,
    });
    return TaskModel.fromJson(res.data as Map<String, dynamic>);
  }

@override
  Future<TaskModel> updateTask(TaskModel task) async {
    final res = await client.put('${ApiConstants.tasksPath}/${task.id}', data: {
      "id": task.id,
      "title": task.title,
      "completed": task.completed,
    });
    return TaskModel.fromJson(res.data as Map<String, dynamic>);
  }


  @override
  Future<void> deleteTask(String id) async {
    await client.delete('${ApiConstants.tasksPath}/$id');
  }

@override
  Future<TaskModel> patchCompleted(String id, bool completed) async {
    final res = await client.put('${ApiConstants.tasksPath}/$id', data: {
      "completed": completed,
    });
    return TaskModel.fromJson(res.data as Map<String, dynamic>);
  }

}
