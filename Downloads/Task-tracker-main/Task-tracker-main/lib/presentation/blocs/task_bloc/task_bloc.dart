import 'package:bloc/bloc.dart';

import '../../../domain/entities/task_entity.dart';
import '../../../domain/entities/task_status.dart';
import '../../../domain/repositories/task_repository.dart';
import '../../../data/datasources/remote/api_client.dart';
import 'task_event.dart';
import 'task_state.dart';

/// Bloc, работающий с TaskRepository (удалённый API).
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;
  final void Function()? onUnauthorized;
  TaskBloc({required this.repository, this.onUnauthorized}) : super(const TaskInitial()) {
    on<LoadTasksEvent>(_onLoad);
    on<RefreshTasksEvent>(_onLoad);
    on<MoveTaskEvent>(_onMove);
    on<CreateTaskEvent>(_onCreate);
  }

  Future<void> _onLoad(TaskEvent event, Emitter<TaskState> emit) async {
    emit(const TaskLoading());
    try {
      final tasks = await repository.getTasks();
      emit(TaskLoaded(tasks));
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        onUnauthorized?.call();
      }
      emit(TaskError('Не удалось загрузить задачи'));
    } catch (_) {
      emit(TaskError('Не удалось загрузить задачи'));
    }
  }

  Future<void> _onMove(MoveTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await repository.moveTask(event.taskId, TaskStatus.values.firstWhere(
        (s) => s.name.toUpperCase() == event.status.toUpperCase(),
        orElse: () => TaskStatus.todo,
      ));
      add(const RefreshTasksEvent());
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        onUnauthorized?.call();
      }
      emit(TaskError('Не удалось обновить статус'));
    } catch (_) {
      emit(TaskError('Не удалось обновить статус'));
    }
  }

  Future<void> _onCreate(CreateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await repository.createTask(TaskEntity(
        id: '',
        title: event.title,
        description: event.description,
        status: TaskStatus.todo,
        projectId: event.projectId,
      ));
      add(const RefreshTasksEvent());
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        onUnauthorized?.call();
      }
      emit(TaskError('Не удалось создать задачу'));
    } catch (_) {
      emit(TaskError('Не удалось создать задачу'));
    }
  }
}
