import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/search_tasks.dart';
import '../../domain/usecases/toggle_completed.dart';
import '../../domain/usecases/update_task.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final SearchTasks searchTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  final ToggleCompleted toggleCompleted;

  TaskBloc({
    required this.getTasks,
    required this.searchTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
    required this.toggleCompleted,
  }) : super(const TaskState.initial()) {
    on<TaskEvent>((event, emit) => event.map(
          load: (_) => _onLoad(emit),
          search: (e) => _onSearch(e.query, emit),
          add: (e) => _onAdd(e.title, emit),
          edit: (e) => _onEdit(e.task, emit),
          delete: (e) => _onDelete(e.id, emit),
          toggle: (e) => _onToggle(e.id, emit),
        ));
  }

  Future<void> _onLoad(Emitter<TaskState> emit) async {
    emit(const TaskState.loading());
    try {
      final tasks = await getTasks(const NoParams());
      emit(TaskState.loaded(tasks));
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onSearch(String query, Emitter<TaskState> emit) async {
    try {
      final tasks = await searchTasks(query);
      emit(TaskState.loaded(tasks));
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onAdd(String title, Emitter<TaskState> emit) async {
    try {
      await addTask(title);
      final tasks = await getTasks(const NoParams());
      emit(TaskState.loaded(tasks));
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onEdit(Task task, Emitter<TaskState> emit) async {
    try {
      await updateTask(task);
      final tasks = await getTasks(const NoParams());
      emit(TaskState.loaded(tasks));
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onDelete(String id, Emitter<TaskState> emit) async {
    try {
      await deleteTask(id);
      final tasks = await getTasks(const NoParams());
      emit(TaskState.loaded(tasks));
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onToggle(String id, Emitter<TaskState> emit) async {
    try {
      await toggleCompleted(id);
      final tasks = await getTasks(const NoParams());
      emit(TaskState.loaded(tasks));
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }
}
