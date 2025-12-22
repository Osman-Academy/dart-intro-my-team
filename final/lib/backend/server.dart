import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:postgres/postgres.dart';

import 'application/usecases/assign_task.dart';
import 'application/usecases/create_task.dart';
import 'application/usecases/get_tasks.dart';
import 'application/usecases/move_task.dart';
import 'application/usecases/update_task.dart';
import 'application/usecases/search_pattern.dart';
import 'infrastructure/persistence/postgres_task_repository.dart';
import 'infrastructure/persistence/postgres_user_repository.dart';
import 'interfaces/http/middleware/auth_middleware.dart';
import 'interfaces/http/task_router.dart';
import 'interfaces/http/auth_router.dart';
import 'interfaces/http/search_router.dart';
import 'services/auth_service.dart';

Future<void> startServer({int port = 8080}) async {
  // Infrastructure
  final conn = await _buildPgConnection();
  final taskRepo = PostgresTaskRepository(conn);
  final userRepo = PostgresUserRepository(conn);
  final authService = AuthService();

  // Application services
  final getTasks = GetTasksUseCase(taskRepo);
  final createTask = CreateTaskUseCase(taskRepo);
  final updateTask = UpdateTaskUseCase(taskRepo);
  final moveTask = MoveTaskUseCase(taskRepo);
  final assignTask = AssignTaskUseCase(taskRepo);
  final searchPattern = SearchPatternUseCase();

  // HTTP interface adapter
  final taskRouter = TaskRouter(
    getTasks: getTasks,
    createTask: createTask,
    updateTask: updateTask,
    moveTask: moveTask,
    assignTask: assignTask,
  );
  final authRouter = AuthRouter(
    authService: authService,
    users: userRepo,
  );
  final searchRouter = SearchRouter(search: searchPattern);

  final router = Router()
    ..mount('/auth', authRouter.router)
    ..mount(
      '/tasks',
      Pipeline()
          .addMiddleware(buildAuthMiddleware(authService, userRepo))
          .addHandler(taskRouter.router),
    )
    ..mount('/search', searchRouter.router);

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_jsonHeaders())
      .addHandler(router);

  await serve(handler, '0.0.0.0', port);
  print('Team Flow Dart API running on http://0.0.0.0:$port');
}

Future<Connection> _buildPgConnection() async {
  final host = Platform.environment['PGHOST'] ?? 'localhost';
  final port = int.tryParse(Platform.environment['PGPORT'] ?? '5432') ?? 5432;
  final db = Platform.environment['PGDATABASE'] ?? 'teamflow';
  final user = Platform.environment['PGUSER'] ?? 'postgres';
  final password = Platform.environment['PGPASSWORD'] ?? 'postgres';

  return await Connection.open(
    Endpoint(
      host: host,
      port: port,
      database: db,
      username: user,
      password: password,
    ),
    settings: const ConnectionSettings(sslMode: SslMode.disable),
  );
}

Middleware _jsonHeaders() {
  return (inner) => (req) async {
    final res = await inner(req);
    return res.change(headers: {
      ...res.headers,
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, OPTIONS',
    });
  };
}

void main(List<String> args) {
  final port = int.tryParse(args.isNotEmpty ? args[0] : '') ?? 8080;
  startServer(port: port);
}
