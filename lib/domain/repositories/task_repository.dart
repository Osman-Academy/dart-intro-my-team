
import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<List<Task>> searchTasks(String query);
  Future<Task> addTask(Task task);
  Future<Task> updateTask(Task task);
  Future<void> deleteTask(String taskId);
  Future<List<Task>> refreshTasks();
  Future<void> toggleTaskCompletion(String taskId);
}
