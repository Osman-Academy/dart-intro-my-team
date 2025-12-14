import 'task_status.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final TaskStatus status;
  final String projectId;
  final String? assigneeId;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.projectId,
    this.assigneeId,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskStatus? status,
    String? projectId,
    String? assigneeId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      projectId: projectId ?? this.projectId,
      assigneeId: assigneeId ?? this.assigneeId,
    );
  }
}
