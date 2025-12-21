import '../../core/usecases/usecase.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class CreateTaskUseCase implements UseCase<TaskEntity, TaskEntity> {
  final TaskRepository repository;
  CreateTaskUseCase(this.repository);

  @override
  Future<TaskEntity> call(TaskEntity params) => repository.createTask(params);
}
