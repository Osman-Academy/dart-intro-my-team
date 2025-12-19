import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/task.dart';

/// Data source responsible for fetching tasks from a remote HTTP API.
class TaskRemoteDataSource {
  final http.Client client;

  TaskRemoteDataSource({required this.client});

  /// Fetch tasks from JSONPlaceholder `todos` endpoint and map to `Task`.
  ///
  /// The example endpoint does not provide a `description` field, so we
  /// set `description` to an empty string here.
  Future<List<Task>> fetchTasks() async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    final response = await client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load tasks: ${response.statusCode}');
    }

    final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;

    return jsonList.map((dynamic item) {
      final map = item as Map<String, dynamic>;
      return Task(
        id: (map['id'] as num).toInt(),
        title: map['title'] as String? ?? '',
        // JSONPlaceholder doesn't include `description`; keep empty.
        description: '',
        completed: map['completed'] as bool? ?? false,
      );
    }).toList();
  }

  /// Post a new task to the server. JSONPlaceholder will accept the POST
  /// and return a created object (but it won't persist between requests).
  Future<Task> postTask({required String title, required String description}) async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    final body = json.encode({
      'title': title,
      'completed': false,
      // include description as a custom field (server may ignore)
      'description': description,
      'userId': 1,
    });

    final response = await client.post(uri, headers: {'Content-Type': 'application/json'}, body: body);

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to add task: ${response.statusCode}');
    }

    final Map<String, dynamic> map = json.decode(response.body) as Map<String, dynamic>;
    return Task(
      id: (map['id'] as num?)?.toInt() ?? DateTime.now().millisecondsSinceEpoch,
      title: map['title'] as String? ?? title,
      description: map['description'] as String? ?? description,
      completed: map['completed'] as bool? ?? false,
    );
  }
}
