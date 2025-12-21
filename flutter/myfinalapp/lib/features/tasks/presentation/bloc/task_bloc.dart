import '../../domain/entities/task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import '../../domain/usecases/update_task_usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasks;
  final AddTaskUseCase addTask;
  final UpdateTaskUseCase updateTask;
  final DeleteTaskUseCase deleteTask;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskState.initial()) {
    on<TaskEvent>((event, emit) async {
      await event.when(
        load: () async {
          emit(state.copyWith(isLoading: true));

          final tasks = await getTasks();

          emit(
            state.copyWith(
              allTasks: tasks,
              filteredTasks: _applySearch(tasks, state.searchQuery),
              isLoading: false,
            ),
          );
        },
        search: (query) async {
          emit(
            state.copyWith(
              searchQuery: query,
              filteredTasks: _applySearch(state.allTasks, query),
            ),
          );
        },
        add: (task) async {
          emit(state.copyWith(isLoading: true));

          final newTask = await addTask(task);
          final updated = [...state.allTasks, newTask];

          emit(
            state.copyWith(
              allTasks: updated,
              filteredTasks: _applySearch(updated, state.searchQuery),
              isLoading: false,
            ),
          );
        },
        update: (task) async {
          emit(state.copyWith(isLoading: true));

          final updatedTask = await updateTask(task);

          final updatedList = state.allTasks
              .map((t) => t.id == updatedTask.id ? updatedTask : t)
              .toList();

          emit(
            state.copyWith(
              allTasks: updatedList,
              filteredTasks: _applySearch(updatedList, state.searchQuery),
              isLoading: false,
            ),
          );
        },
        delete: (id) async {
          emit(state.copyWith(isLoading: true));

          await deleteTask(id);

          final updatedList = state.allTasks.where((t) => t.id != id).toList();

          emit(
            state.copyWith(
              allTasks: updatedList,
              filteredTasks: _applySearch(updatedList, state.searchQuery),
              isLoading: false,
            ),
          );
        },
      );
    });
  }

  List<Task> _applySearch(List<Task> tasks, String query) {
    if (query.isEmpty) return tasks;

    final lower = query.toLowerCase();

    return tasks.where((t) => t.title.toLowerCase().contains(lower)).toList();
  }
}
