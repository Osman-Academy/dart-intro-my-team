
import 'package:dartz/dartz.dart';
import '../entities/task.dart' as task_entity;
import '../repositories/task_repository.dart';

abstract class TaskUseCase {
  Future<Either<Exception, List<task_entity.Task>>> execute();
}

class GetTasksUseCase implements TaskUseCase {
  final TaskRepository _repository;

  GetTasksUseCase(this._repository);

  @override
  Future<Either<Exception, List<task_entity.Task>>> execute() async {
    try {
      final tasks = await _repository.getTasks();
      return Right(tasks);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}

class AddTaskUseCase implements TaskUseCase {
  final TaskRepository _repository;
  final task_entity.Task _task;

  AddTaskUseCase(this._repository, this._task);

  @override
  Future<Either<Exception, List<task_entity.Task>>> execute() async {
    try {
      await _repository.addTask(_task);
      final tasks = await _repository.getTasks();
      return Right(tasks);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}

class UpdateTaskUseCase implements TaskUseCase {
  final TaskRepository _repository;
  final task_entity.Task _task;

  UpdateTaskUseCase(this._repository, this._task);

  @override
  Future<Either<Exception, List<task_entity.Task>>> execute() async {
    try {
      await _repository.updateTask(_task);
      final tasks = await _repository.getTasks();
      return Right(tasks);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}

class DeleteTaskUseCase implements TaskUseCase {
  final TaskRepository _repository;
  final String _taskId;

  DeleteTaskUseCase(this._repository, this._taskId);

  @override
  Future<Either<Exception, List<task_entity.Task>>> execute() async {
    try {
      await _repository.deleteTask(_taskId);
      final tasks = await _repository.getTasks();
      return Right(tasks);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}

class ToggleTaskCompletionUseCase implements TaskUseCase {
  final TaskRepository _repository;
  final String _taskId;

  ToggleTaskCompletionUseCase(this._repository, this._taskId);

  @override
  Future<Either<Exception, List<task_entity.Task>>> execute() async {
    try {
      await _repository.toggleTaskCompletion(_taskId);
      final tasks = await _repository.getTasks();
      return Right(tasks);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}

class RefreshTasksUseCase implements TaskUseCase {
  final TaskRepository _repository;

  RefreshTasksUseCase(this._repository);

  @override
  Future<Either<Exception, List<task_entity.Task>>> execute() async {
    try {
      final tasks = await _repository.refreshTasks();
      return Right(tasks);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
