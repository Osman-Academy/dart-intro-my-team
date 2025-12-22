import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../application/usecases/search_pattern.dart';

class SearchRouter {
  final SearchPatternUseCase search;

  SearchRouter({required this.search});

  Router get router {
    final r = Router();
    r.post('/', _search);
    return r;
  }

  Future<Response> _search(Request req) async {
    try {
      final body = await req.readAsString();
      final data = body.isNotEmpty ? json.decode(body) as Map<String, dynamic> : <String, dynamic>{};
      final text = data['text'] as String? ?? '';
      final pattern = data['pattern'] as String? ?? '';
      final caseSensitive = data['caseSensitive'] as bool? ?? false;

      final matches = search.execute(text: text, pattern: pattern, caseSensitive: caseSensitive);
      return Response.ok(json.encode({
        'matches': matches.map((m) => m.toJson()).toList(),
      }));
    } catch (e) {
      return Response(400, body: json.encode({'error': e.toString()}));
    }
  }
}
