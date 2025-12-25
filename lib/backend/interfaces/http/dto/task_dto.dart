import '../../../domain/task.dart';
import '../../../domain/task_status.dart';

class TaskDto {
  static Map<String, dynamic> toJson(Task task) => {
        'id': task.id,
        'title': task.title,
        'description': task.description,
        'status': task.status.name.toUpperCase(),
        'projectId': task.projectId,
        'assigneeId': task.assigneeId,
      };

  static TaskStatus parseStatus(String? value) {
    if (value == null) return TaskStatus.todo;
    final normalized = value.replaceAll('-', '').replaceAll('_', '').toLowerCase();
    return TaskStatus.values.firstWhere(
      (e) => e.name.replaceAll('_', '').toLowerCase() == normalized,
      orElse: () => TaskStatus.todo,
    );
  }
}
