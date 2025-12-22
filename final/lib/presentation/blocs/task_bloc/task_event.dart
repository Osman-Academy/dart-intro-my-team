import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends TaskEvent {
  const LoadTasksEvent();
}

class RefreshTasksEvent extends TaskEvent {
  const RefreshTasksEvent();
}

class MoveTaskEvent extends TaskEvent {
  final String taskId;
  final String status; // TODO: use TaskStatus if exposed here
  const MoveTaskEvent({required this.taskId, required this.status});

  @override
  List<Object?> get props => [taskId, status];
}

class CreateTaskEvent extends TaskEvent {
  final String title;
  final String description;
  final String projectId;
  const CreateTaskEvent({
    required this.title,
    required this.description,
    required this.projectId,
  });

  @override
  List<Object?> get props => [title, description, projectId];
}
