import 'task.dart';
import 'task_status.dart';

abstract class TaskRepository {
  Future<List<Task>> findAll();
  Future<Task> create(Task task);
  Future<Task?> findById(String id);
  Future<Task> update(Task task);
  Future<Task> move(String taskId, TaskStatus status);
  Future<Task> assign(String taskId, String? userId);
}
