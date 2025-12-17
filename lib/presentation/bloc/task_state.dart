import 'package:equatable/equatable.dart';
import 'package:flutter_application_finall_project/domain/entities/task.dart';

/// Base state for TaskBloc.
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the app starts.
class TaskInitial extends TaskState {}

/// State when tasks are being fetched.
class TaskLoading extends TaskState {}

/// State when a refresh is in progress (for pull-to-refresh).
class TaskRefreshing extends TaskState {
  final List<Task> previousTasks;

  const TaskRefreshing(this.previousTasks);

  @override
  List<Object?> get props => [previousTasks];
}

/// State when tasks have been successfully loaded.
class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final String? searchQuery;

  const TaskLoaded(this.tasks, {this.searchQuery});

  @override
  List<Object?> get props => [tasks, searchQuery];
}

/// State when the task list is empty.
class TaskEmpty extends TaskState {}

/// State when an error occurs.
class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when an operation (add/delete/update) is in progress.
class TaskOperationLoading extends TaskState {
  final List<Task> currentTasks;

  const TaskOperationLoading(this.currentTasks);

  @override
  List<Object?> get props => [currentTasks];
}

/// State when a task has been successfully added.
class TaskAdded extends TaskState {
  final Task newTask;
  final List<Task> updatedTasks;

  const TaskAdded(this.newTask, this.updatedTasks);

  @override
  List<Object?> get props => [newTask, updatedTasks];
}

/// State when a task has been successfully updated.
class TaskUpdated extends TaskState {
  final Task updatedTask;
  final List<Task> allTasks;

  const TaskUpdated(this.updatedTask, this.allTasks);

  @override
  List<Object?> get props => [updatedTask, allTasks];
}

/// State when a task has been successfully deleted.
class TaskDeleted extends TaskState {
  final int deletedTaskId;
  final List<Task> remainingTasks;

  const TaskDeleted(this.deletedTaskId, this.remainingTasks);

  @override
  List<Object?> get props => [deletedTaskId, remainingTasks];
}
