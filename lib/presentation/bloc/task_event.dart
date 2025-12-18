import 'package:equatable/equatable.dart';

// Events
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;
  final String description;

  const AddTaskEvent({
    required this.title,
    required this.description,
  });

  @override
  List<Object> get props => [title, description];
}

class ToggleTaskEvent extends TaskEvent {
  final String taskId;

  const ToggleTaskEvent({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  const DeleteTaskEvent({required this.taskId});

  @override
  List<Object> get props => [taskId];
}


class RefreshTasks extends TaskEvent {}

class SearchTasks extends TaskEvent {
  final String query;

  const SearchTasks({required this.query});

  @override
  List<Object> get props => [query];
}
