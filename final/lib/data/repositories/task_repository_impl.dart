import '../../domain/entities/task_entity.dart';
import '../../domain/entities/task_status.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/remote/task_remote_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remote;

  TaskRepositoryImpl({required this.remote});

  @override
  Future<TaskEntity> assignTask(String taskId, String userId) async {
    final model = await remote.assignTask(taskId, userId);
    return model.toEntity();
  }

  @override
  Future<TaskEntity> createTask(TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    final created = await remote.createTask(model);
    return created.toEntity();
  }

  @override
  Future<List<TaskEntity>> getTasks() async {
    final items = await remote.fetchTasks();
    return items.map((e) => e.toEntity()).toList();
  }

  @override
  Future<TaskEntity> moveTask(String taskId, TaskStatus status) async {
    final updated = await remote.moveTask(taskId, status.name.toUpperCase());
    return updated.toEntity();
  }

  @override
  Future<TaskEntity> updateTask(TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    final updated = await remote.updateTask(model);
    return updated.toEntity();
  }
}
