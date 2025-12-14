import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'application/usecases/assign_task.dart';
import 'application/usecases/create_task.dart';
import 'application/usecases/get_tasks.dart';
import 'application/usecases/move_task.dart';
import 'application/usecases/update_task.dart';
import 'infrastructure/persistence/in_memory_task_repository.dart';
import 'interfaces/http/task_router.dart';

Future<void> startServer({int port = 8080}) async {
  // Infrastructure
  final repo = InMemoryTaskRepository();

  // Application services
  final getTasks = GetTasksUseCase(repo);
  final createTask = CreateTaskUseCase(repo);
  final updateTask = UpdateTaskUseCase(repo);
  final moveTask = MoveTaskUseCase(repo);
  final assignTask = AssignTaskUseCase(repo);

  // HTTP interface adapter
  final taskRouter = TaskRouter(
    getTasks: getTasks,
    createTask: createTask,
    updateTask: updateTask,
    moveTask: moveTask,
    assignTask: assignTask,
  );

  final router = Router()..mount('/tasks', taskRouter.router);

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_jsonHeaders())
      .addHandler(router);

  await serve(handler, '0.0.0.0', port);
  print('Team Flow Dart API running on http://0.0.0.0:$port');
}

Middleware _jsonHeaders() {
  return (inner) => (req) async {
    final res = await inner(req);
    return res.change(headers: {
      ...res.headers,
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'Content-Type',
    });
  };
}

void main(List<String> args) {
  final port = int.tryParse(args.isNotEmpty ? args[0] : '') ?? 8080;
  startServer(port: port);
}
