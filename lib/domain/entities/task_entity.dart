import 'package:equatable/equatable.dart';

import 'task_status.dart';
import 'user_entity.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final TaskStatus status;
  final String projectId;
  final UserEntity? assignee;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.projectId,
    this.assignee,
  });

  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    TaskStatus? status,
    String? projectId,
    UserEntity? assignee,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      projectId: projectId ?? this.projectId,
      assignee: assignee ?? this.assignee,
    );
  }

  @override
  List<Object?> get props => [id, title, description, status, projectId, assignee];
}
