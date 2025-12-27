import 'package:equatable/equatable.dart';
import '../../domain/models/task.dart';

/// States emitted by TaskBloc.
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

/// Loading state while tasks are being fetched.
class TaskLoading extends TaskState {}

/// Loaded state with list of tasks.
class TaskLoaded extends TaskState {
  final List<Task> allTasks;
  final List<Task> filteredTasks;
  final String query;

  const TaskLoaded({required this.allTasks, required this.filteredTasks, this.query = ''});

  @override
  List<Object?> get props => [allTasks, filteredTasks, query];
}

/// Error state with message.
class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}
