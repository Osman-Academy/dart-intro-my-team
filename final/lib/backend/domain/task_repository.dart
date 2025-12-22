import 'task.dart';
import 'task_status.dart';

abstract class TaskRepository {
  Future<List<Task>> findAll(String ownerId);
  Future<Task> create(Task task);
  Future<Task?> findById(String id, String ownerId);
  Future<Task> update(Task task, String ownerId);
  Future<Task> move(String taskId, TaskStatus status, String ownerId);
  Future<Task> assign(String taskId, String? userId, String ownerId);
}
