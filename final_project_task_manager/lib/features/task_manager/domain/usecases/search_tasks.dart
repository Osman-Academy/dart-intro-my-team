import '../../../../core/usecase/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class SearchTasks implements UseCase<List<Task>, String> {
  final TaskRepository repo;
  SearchTasks(this.repo);

  @override
  Future<List<Task>> call(String pattern) => repo.searchTasks(pattern);
}
