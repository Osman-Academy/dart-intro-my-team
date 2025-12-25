import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../application/usecases/assign_task.dart';
import '../../application/usecases/create_task.dart';
import '../../application/usecases/get_tasks.dart';
import '../../application/usecases/move_task.dart';
import '../../application/usecases/update_task.dart';
import '../../domain/task.dart';
import '../../domain/task_status.dart';
import 'dto/task_dto.dart';
import 'middleware/auth_middleware.dart';

class TaskRouter {
  final GetTasksUseCase getTasks;
  final CreateTaskUseCase createTask;
  final UpdateTaskUseCase updateTask;
  final MoveTaskUseCase moveTask;
  final AssignTaskUseCase assignTask;

  TaskRouter({
    required this.getTasks,
    required this.createTask,
    required this.updateTask,
    required this.moveTask,
    required this.assignTask,
  });

  Router get router {
    final router = Router();

    router.get('/', _handleGetAll);
    router.post('/', _handleCreate);
    router.put('/<id>', _handleUpdate);
    router.put('/<id>/move', _handleMove);
    router.put('/<id>/assign', _handleAssign);

    // OPTIONS for CORS preflight
    router.options('/<ignored|.*>', (Request _) => Response.ok(''));

    return router;
  }

  Future<Response> _handleGetAll(Request req) async {
    final ownerId = req.user?.id;
    if (ownerId == null) return Response(401, body: jsonEncode({'error': 'unauthorized'}));
    final tasks = await getTasks(ownerId);
    return Response.ok(jsonEncode(tasks.map(TaskDto.toJson).toList()));
  }

  Future<Response> _handleCreate(Request req) async {
    final ownerId = req.user?.id;
    if (ownerId == null) return Response(401, body: jsonEncode({'error': 'unauthorized'}));
    final payload = await _readJson(req);
    final title = payload['title'] as String? ?? '';
    final description = payload['description'] as String? ?? '';
    final projectId = payload['projectId'] as String? ?? 'default';
    final assigneeId = payload['assigneeId'] as String?;

    if (title.trim().isEmpty) {
      return Response(400, body: jsonEncode({'error': 'title is required'}));
    }

    final created = await createTask(
      CreateTaskParams(
        title: title,
        description: description,
        projectId: projectId,
        ownerId: ownerId,
        assigneeId: assigneeId,
      ),
    );
    return Response.ok(jsonEncode(TaskDto.toJson(created)));
  }

  Future<Response> _handleUpdate(Request req, String id) async {
    final ownerId = req.user?.id;
    if (ownerId == null) return Response(401, body: jsonEncode({'error': 'unauthorized'}));
    final payload = await _readJson(req);
    final existing = await _findOr404(id, ownerId);
    if (existing == null) return Response.notFound(jsonEncode({'error': 'not_found'}));

    final updated = existing.copyWith(
      title: payload['title'] as String? ?? existing.title,
      description: payload['description'] as String? ?? existing.description,
      projectId: payload['projectId'] as String? ?? existing.projectId,
    );
    final result = await updateTask(updated, ownerId);
    return Response.ok(jsonEncode(TaskDto.toJson(result)));
  }

  Future<Response> _handleMove(Request req, String id) async {
    final ownerId = req.user?.id;
    if (ownerId == null) return Response(401, body: jsonEncode({'error': 'unauthorized'}));
    final payload = await _readJson(req);
    final statusStr = payload['status'] as String? ?? 'TODO';
    final status = TaskDto.parseStatus(statusStr);
    try {
      final result = await moveTask(MoveTaskParams(taskId: id, status: status, ownerId: ownerId));
      return Response.ok(jsonEncode(TaskDto.toJson(result)));
    } catch (_) {
      return Response.notFound(jsonEncode({'error': 'not_found'}));
    }
  }

  Future<Response> _handleAssign(Request req, String id) async {
    final ownerId = req.user?.id;
    if (ownerId == null) return Response(401, body: jsonEncode({'error': 'unauthorized'}));
    final payload = await _readJson(req);
    final userId = payload['userId'] as String?;
    try {
      final result = await assignTask(AssignTaskParams(taskId: id, userId: userId, ownerId: ownerId));
      return Response.ok(jsonEncode(TaskDto.toJson(result)));
    } catch (_) {
      return Response.notFound(jsonEncode({'error': 'not_found'}));
    }
  }

  Future<Map<String, dynamic>> _readJson(Request req) async {
    final body = await req.readAsString();
    if (body.isEmpty) return {};
    final decoded = jsonDecode(body);
    if (decoded is Map<String, dynamic>) return decoded;
    return {};
  }

  Future<Task?> _findOr404(String id, String ownerId) async {
    final tasks = await getTasks(ownerId);
    try {
      return tasks.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }
}
