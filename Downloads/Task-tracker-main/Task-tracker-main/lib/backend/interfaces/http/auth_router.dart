import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../domain/user.dart';
import '../../domain/user_role.dart';
import '../../domain/user_repository.dart';
import '../../services/auth_service.dart';
import 'middleware/auth_middleware.dart';

class AuthRouter {
  final AuthService authService;
  final UserRepository users;

  AuthRouter({
    required this.authService,
    required this.users,
  });

  Router get router {
    final router = Router();

    router.post('/register', _register);
    router.post('/login', _login);
    router.get('/me', _me);

    // OPTIONS for CORS
    router.options('/<ignored|.*>', (Request _) => Response.ok(''));

    return router;
  }

  Future<Response> _register(Request req) async {
    final payload = await _readJson(req);
    final name = (payload['name'] as String? ?? '').trim();
    final email = (payload['email'] as String? ?? '').trim().toLowerCase();
    final password = payload['password'] as String? ?? '';
    final roleStr = payload['role'] as String? ?? 'developer';
    final avatarUrl = payload['avatarUrl'] as String?;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      return Response(400, body: jsonEncode({'error': 'name_email_password_required'}));
    }

    final existing = await users.findByEmail(email);
    if (existing != null) {
      return Response(409, body: jsonEncode({'error': 'email_taken'}));
    }

    final role = UserRole.parse(roleStr);
    final hashed = authService.hashPassword(password);
    final created = await users.create(User(
      id: '',
      name: name,
      email: email,
      role: role,
      passwordHash: hashed,
      avatarUrl: avatarUrl,
    ));

    final token = authService.signToken(created);
    return Response.ok(jsonEncode(_authResponse(created, token)));
  }

  Future<Response> _login(Request req) async {
    final payload = await _readJson(req);
    final email = (payload['email'] as String? ?? '').trim().toLowerCase();
    final password = payload['password'] as String? ?? '';
    if (email.isEmpty || password.isEmpty) {
      return Response(400, body: jsonEncode({'error': 'email_password_required'}));
    }
    final user = await users.findByEmail(email);
    if (user == null || !authService.verifyPassword(password, user.passwordHash)) {
      return Response(401, body: jsonEncode({'error': 'invalid_credentials'}));
    }
    final token = authService.signToken(user);
    return Response.ok(jsonEncode(_authResponse(user, token)));
  }

  Future<Response> _me(Request req) async {
    // Auth is not enforced at router level, so validate token here.
    final authHeader = req.headers['Authorization'] ?? req.headers['authorization'];
    if (authHeader == null || !authHeader.startsWith('Bearer ')) {
      return Response(401, body: jsonEncode({'error': 'unauthorized'}));
    }
    final token = authHeader.substring('Bearer '.length).trim();
    final jwt = authService.verifyToken(token);
    final userId = jwt?.subject;
    if (jwt == null || userId == null) {
      return Response(401, body: jsonEncode({'error': 'invalid_token'}));
    }
    final user = await users.findById(userId);
    if (user == null) return Response(401, body: jsonEncode({'error': 'user_not_found'}));
    return Response.ok(jsonEncode(_userJson(user)));
  }

  Future<Map<String, dynamic>> _readJson(Request req) async {
    final body = await req.readAsString();
    if (body.isEmpty) return {};
    final decoded = jsonDecode(body);
    if (decoded is Map<String, dynamic>) return decoded;
    return {};
  }

  Map<String, dynamic> _authResponse(User user, String token) => {
        'token': token,
        'user': _userJson(user),
      };

  Map<String, dynamic> _userJson(User user) => {
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'role': user.role.value,
        'avatarUrl': user.avatarUrl,
      };
}
