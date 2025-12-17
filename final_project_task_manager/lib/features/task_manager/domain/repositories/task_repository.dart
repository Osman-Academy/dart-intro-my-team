import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<List<Task>> searchTasks(String pattern);

  Future<Task> addTask(String title);
  Future<Task> updateTask(Task task); // edit title / completed
  Future<void> deleteTask(String id);
  Future<Task> toggleCompleted(String id); // completed true/false
}
