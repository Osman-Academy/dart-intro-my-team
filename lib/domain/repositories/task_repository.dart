import '../models/task.dart';

/// Repository interface for Tasks in the domain layer.
/// Implementation lives in the data layer and hides data-source details.
abstract class TaskRepository {
  /// Fetch all tasks from the data source.
  Future<List<Task>> getTasks();

  /// Add a new task to the data source.
  Future<Task> addTask(Task task);

  /// Search tasks by a query string (title or description).
  /// Implementations may perform server-side search or client-side filtering.
  Future<List<Task>> searchTasks(String query);
}
