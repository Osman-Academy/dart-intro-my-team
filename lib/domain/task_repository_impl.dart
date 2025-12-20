import 'task.dart';
import '../domain/task_repository.dart';
import '../data/task_remote_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remote;

  TaskRepositoryImpl(this.remote);

  @override
  Future<List<Task>> getTasks() async {
    final data = await remote.getTasks();
    return data.map<Task>((e) => Task.fromJson(e)).toList();
  }
  @override
  Future<void> addTask(Task task) async {
    await remote.addTask(task.toJson()); 
  }

  
}
