import '../entities/task_entity.dart';
import '../entities/task_status.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getTasks();
  Future<TaskEntity> createTask(TaskEntity task);
  Future<TaskEntity> updateTask(TaskEntity task);
  Future<TaskEntity> moveTask(String taskId, TaskStatus status);
  Future<TaskEntity> assignTask(String taskId, String userId);
}
