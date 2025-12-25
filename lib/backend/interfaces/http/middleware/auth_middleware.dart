import 'package:shelf/shelf.dart';

import '../../../services/auth_service.dart';
import '../../../domain/user.dart';
import '../../../domain/user_repository.dart';

Middleware buildAuthMiddleware(AuthService authService, UserRepository users) {
  return (Handler innerHandler) {
    return (Request request) async {
      // Allow CORS preflight without auth
      if (request.method.toUpperCase() == 'OPTIONS') {
        return Response.ok('');
      }

      final authHeader = request.headers['Authorization'] ?? request.headers['authorization'];
      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response(401, body: '{"error":"unauthorized"}');
      }

      final token = authHeader.substring('Bearer '.length).trim();
      final jwt = authService.verifyToken(token);
      if (jwt == null) {
        return Response(401, body: '{"error":"invalid_token"}');
      }

      final userId = jwt.subject;
      if (userId == null) {
        return Response(401, body: '{"error":"invalid_token"}');
      }

      final user = await users.findById(userId);
      if (user == null) {
        return Response(401, body: '{"error":"user_not_found"}');
      }

      final enriched = request.change(context: {'user': user});
      return await innerHandler(enriched);
    };
  };
}

extension RequestUserExtension on Request {
  User? get user => context['user'] as User?;
}
