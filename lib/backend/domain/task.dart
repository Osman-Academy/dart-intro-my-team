import 'task_status.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final TaskStatus status;
  final String projectId;
  final String? assigneeId;
  final String ownerId;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.projectId,
    required this.ownerId,
    this.assigneeId,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskStatus? status,
    String? projectId,
    String? assigneeId,
    String? ownerId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      projectId: projectId ?? this.projectId,
      ownerId: ownerId ?? this.ownerId,
      assigneeId: assigneeId ?? this.assigneeId,
    );
  }
}
