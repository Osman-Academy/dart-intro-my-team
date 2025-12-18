import 'package:equatable/equatable.dart';
import '../../domain/entities/task.dart';

// States
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskError extends TaskState {
  final String message;

  const TaskError({required this.message});

  @override
  List<Object> get props => [message];
}


class TaskEmpty extends TaskState {}

class TaskSearchLoaded extends TaskState {
  final List<Task> tasks;
  final String query;

  const TaskSearchLoaded({required this.tasks, required this.query});

  @override
  List<Object> get props => [tasks, query];
}

class TaskSearchEmpty extends TaskState {
  final String query;

  const TaskSearchEmpty({required this.query});

  @override
  List<Object> get props => [query];
}
