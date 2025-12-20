import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/task.dart';
import '../domain/task_repository.dart';

abstract class TaskEvent {}
class LoadTasks extends TaskEvent {}

abstract class TaskState {}
class TaskInitial extends TaskState {}
class TaskLoading extends TaskState {}
class TaskLoaded extends TaskState {
  final List<Task> tasks;
  TaskLoaded(this.tasks);
}
class TaskError extends TaskState {}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskInitial()) {
    
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await repository.getTasks();
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError());
      }
    });

    on<AddTask>((event, emit) async {
      try {
        await repository.addTask(event.task);
        add(LoadTasks()); 
      } catch (e) {
        emit(TaskError());
      }
    });

  }
}
class AddTask extends TaskEvent {
  final Task task;
  AddTask(this.task);
}


