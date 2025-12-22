import '../../core/usecases/usecase.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetTasksUseCase implements UseCase<List<TaskEntity>, NoParams> {
  final TaskRepository repository;
  GetTasksUseCase(this.repository);

  @override
  Future<List<TaskEntity>> call(NoParams params) {
    return repository.getTasks();
  }
}
