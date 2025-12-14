import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client _client;

  ApiClient({required this.baseUrl, http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> get(String path) async {
    final resp = await _client.get(Uri.parse('$baseUrl$path'));
    _ensureSuccess(resp);
    return jsonDecode(resp.body);
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final resp = await _client.post(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    _ensureSuccess(resp);
    return jsonDecode(resp.body);
  }

  Future<dynamic> put(String path, Map<String, dynamic> body) async {
    final resp = await _client.put(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    _ensureSuccess(resp);
    return jsonDecode(resp.body);
  }

  void _ensureSuccess(http.Response resp) {
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw Exception('API error ${resp.statusCode}: ${resp.body}');
    }
  }
}
