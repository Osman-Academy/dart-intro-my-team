
import '../../domain/entities/task.dart';


abstract class TaskDataSource {
  Future<List<Task>> getTasks();
  Future<List<Task>> searchTasks(String query);
  Future<Task> addTask(Task task);
  Future<Task> updateTask(Task task);
  Future<void> deleteTask(String taskId);
  Future<void> toggleTaskCompletion(String taskId);
}

class MockTaskDataSource implements TaskDataSource {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Complete Flutter Project',
      description: 'Build a complete task manager app with Clean Architecture',
      isCompleted: false,
      createdAt: DateTime.now(),
    ),
    Task(
      id: '2',
      title: 'Review Code',
      description: 'Review and refactor the codebase',
      isCompleted: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Task(
      id: '3',
      title: 'Write Tests',
      description: 'Add unit tests for all components',
      isCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  Future<List<Task>> getTasks() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_tasks);
  }

  @override
  Future<Task> addTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _tasks.add(task);
    return task;
  }

  @override
  Future<Task> updateTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
    return task;
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _tasks.removeWhere((task) => task.id == taskId);
  }


  @override
  Future<void> toggleTaskCompletion(String taskId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      final task = _tasks[index];
      _tasks[index] = task.copyWith(
        isCompleted: !task.isCompleted,
        updatedAt: DateTime.now(),
      );
    }
  }

  @override
  Future<List<Task>> searchTasks(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    
    if (query.trim().isEmpty) {
      return List.from(_tasks);
    }
    
    return _tasks.where((task) {
      return task.title.toLowerCase().contains(query.toLowerCase()) ||
             task.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
