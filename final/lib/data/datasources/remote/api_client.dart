import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client _client;
  final Future<String?> Function()? tokenProvider;

  ApiClient({
    required this.baseUrl,
    this.tokenProvider,
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<Map<String, String>> _headers({Map<String, String>? extra}) async {
    final headers = <String, String>{'Content-Type': 'application/json', ...?extra};
    final token = await tokenProvider?.call();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<dynamic> get(String path) async {
    final resp = await _client.get(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(),
    );
    _ensureSuccess(resp);
    return _decodeBody(resp.body);
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final resp = await _client.post(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(),
      body: jsonEncode(body),
    );
    _ensureSuccess(resp);
    return _decodeBody(resp.body);
  }

  Future<dynamic> put(String path, Map<String, dynamic> body) async {
    final resp = await _client.put(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(),
      body: jsonEncode(body),
    );
    _ensureSuccess(resp);
    return _decodeBody(resp.body);
  }

  dynamic _decodeBody(String body) {
    if (body.isEmpty) return null;
    return jsonDecode(body);
  }

  void _ensureSuccess(http.Response resp) {
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw ApiException(resp.statusCode, resp.body);
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() => 'ApiException($statusCode): $message';
}
