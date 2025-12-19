import 'package:equatable/equatable.dart';

/// Events for TaskBloc.
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load tasks from repository.
class LoadTasks extends TaskEvent {
  const LoadTasks();
}

/// Add a new task with title and description.
class AddTask extends TaskEvent {
  final String title;
  final String description;

  const AddTask({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}

/// Search/filter tasks by query string.
class SearchTasks extends TaskEvent {
  final String query;

  const SearchTasks(this.query);

  @override
  List<Object?> get props => [query];
}

/// Toggle task completion by id.
class ToggleTask extends TaskEvent {
  final int id;

  const ToggleTask(this.id);

  @override
  List<Object?> get props => [id];
}
