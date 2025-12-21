import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_data_source.dart';
import '../models/task_dto.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remote;

  TaskRepositoryImpl(this.remote);

  @override
  Future<List<Task>> getTasks() async {
    final dtos = await remote.getTasks();
    return dtos.map((e) => e.toDomain()).toList();
  }

  @override
  Future<Task> addTask(Task task) async {
    final dto = TaskDto.fromDomain(task);
    final result = await remote.addTask(dto);
    return result.toDomain();
  }

  @override
  Future<Task> updateTask(Task task) async {
    final dto = TaskDto.fromDomain(task);
    final result = await remote.updateTask(dto);
    return result.toDomain();
  }

  @override
  Future<void> deleteTask(int id) async {
    await remote.deleteTask(id);
  }
}
