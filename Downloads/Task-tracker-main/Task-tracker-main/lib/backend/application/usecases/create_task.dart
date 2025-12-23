import 'package:uuid/uuid.dart';

import '../../domain/task.dart';
import '../../domain/task_repository.dart';
import '../../domain/task_status.dart';

class CreateTaskParams {
  final String title;
  final String description;
  final String projectId;
  final String? assigneeId;
  final String ownerId;

  CreateTaskParams({
    required this.title,
    required this.description,
    required this.projectId,
    required this.ownerId,
    this.assigneeId,
  });
}

class CreateTaskUseCase {
  final TaskRepository repository;
  CreateTaskUseCase(this.repository);

  Future<Task> call(CreateTaskParams params) async {
    final task = Task(
      id: const Uuid().v4(),
      title: params.title,
      description: params.description,
      status: TaskStatus.todo,
      projectId: params.projectId,
      ownerId: params.ownerId,
      assigneeId: params.assigneeId,
    );
    return repository.create(task);
  }
}
