import '../../domain/models/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_data_source.dart';

/// Concrete implementation of `TaskRepository` that uses a remote data source.
class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Task>> getTasks() async {
    try {
      return await remoteDataSource.fetchTasks();
    } catch (e) {
      // Here we simply rethrow; in a production app you'd map exceptions
      // to domain-specific failures or use a Result/Either type.
      rethrow;
    }
  }

  @override
  Future<Task> addTask(Task task) async {
    try {
      // Use remote API to create task and return created Task
      return await remoteDataSource.postTask(title: task.title, description: task.description);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Task>> searchTasks(String query) async {
    try {
      final all = await remoteDataSource.fetchTasks();
      final q = query.toLowerCase();
      return all.where((t) => t.title.toLowerCase().contains(q) || t.description.toLowerCase().contains(q)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
