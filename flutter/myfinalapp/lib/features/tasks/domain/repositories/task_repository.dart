import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
}
