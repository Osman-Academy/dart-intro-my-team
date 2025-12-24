import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

Future<void> main(List<String> args) async {
  final router = Router();

  router.get('/products', (Request request) async {
    final pattern = request.url.queryParameters['q']; // pattern search
    final file = File('data/tools.json');
    final raw = await file.readAsString();
    final List<dynamic> items = jsonDecode(raw);

    if (pattern == null || pattern.trim().isEmpty) {
      return Response.ok(jsonEncode(items), headers: {'Content-Type': 'application/json'});
    }

    final filtered = items.where((e) {
      final title = (e['title'] ?? '').toString();
      return matchesPattern(title, pattern);
    }).toList();

    return Response.ok(jsonEncode(filtered), headers: {'Content-Type': 'application/json'});
  });

  router.get('/products/<id|[0-9]+>', (Request request, String id) async {
  final file = File('data/tools.json');
  final raw = await file.readAsString();
  final decoded = jsonDecode(raw);

  final List<dynamic> items;
  if (decoded is List) {
    items = decoded;
  } else if (decoded is Map && decoded['products'] is List) {
    items = List<dynamic>.from(decoded['products']);
  } else {
    return Response.internalServerError(body: 'Invalid JSON format');
  }

  final intId = int.tryParse(id);
  if (intId == null) return Response(400, body: 'Invalid id');

  final item = items.cast<Map<String, dynamic>>().firstWhere(
    (e) => e['id'] == intId,
    orElse: () => {},
  );

  if (item.isEmpty) {
    return Response.notFound(jsonEncode({'message': 'Not found'}), headers: {
      'Content-Type': 'application/json',
    });
  }

  return Response.ok(jsonEncode(item), headers: {
    'Content-Type': 'application/json',
  });
});


  final handler = Pipeline()
      .addMiddleware(corsHeaders())
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 3000);
  print('Backend running on http://${server.address.host}:${server.port}');
}

bool matchesPattern(String text, String pattern) {
  pattern = pattern.trim();

  // /regex/
  if (pattern.length >= 2 && pattern.startsWith('/') && pattern.endsWith('/')) {
    final re = RegExp(pattern.substring(1, pattern.length - 1), caseSensitive: false);
    return re.hasMatch(text);
  }

  // wildcard: * and ?
  final escaped = RegExp.escape(pattern)
      .replaceAll(r'\*', '.*')
      .replaceAll(r'\?', '.');

  final re = RegExp('^$escaped\$', caseSensitive: false);
  return re.hasMatch(text);
}
