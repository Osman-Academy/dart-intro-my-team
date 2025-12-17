import '../../../../core/usecase/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetTasks implements UseCase<List<Task>, NoParams> {
  final TaskRepository repo;
  GetTasks(this.repo);

  @override
  Future<List<Task>> call(NoParams params) => repo.getTasks();
}
