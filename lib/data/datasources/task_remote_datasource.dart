import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_application_finall_project/core/errors/exceptions.dart';
import 'package:flutter_application_finall_project/data/models/task_model.dart';

const String _baseUrl = 'https://jsonplaceholder.typicode.com';

/// DataSource responsible for fetching, creating, updating, and deleting tasks via HTTP.
class TaskRemoteDataSource {
  final http.Client client;

  TaskRemoteDataSource({required this.client});

  /// Fetches all todos from the example endpoint and maps them into [TaskModel].
  /// Throws [ServerException] on non-200 responses.
  Future<List<TaskModel>> fetchTasks() async {
    final uri = Uri.parse('$_baseUrl/todos');
    final response = await client.get(uri, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode != 200) {
      throw ServerException('Failed to fetch tasks: ${response.statusCode}');
    }

    final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
    // Map server JSON to our TaskModel. The placeholder API does not include
    // a `description` field, so we default it to an empty string.
    final tasks = jsonList.map((jsonItem) {
      final map = jsonItem as Map<String, dynamic>;
      return TaskModel.fromJson({
        'id': map['id'] as int,
        'title': map['title'] as String,
        'description': '', // Placeholder API does not include description
        'completed': map['completed'] as bool,
      });
    }).toList();

    return tasks;
  }

  /// Creates a new task on the server and returns the created TaskModel.
  /// Note: The JSONPlaceholder API accepts POST but doesn't persist data.
  /// Returns a simulated model with a generated ID.
  Future<TaskModel> createTask({
    required String title,
    required String description,
    String? priority,
    String? dueDate,
  }) async {
    final uri = Uri.parse('$_baseUrl/todos');
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'completed': false,
        'userId': 1,
        'priority': priority ?? 'medium',
        'dueDate': dueDate,
      }),
    );

    if (response.statusCode != 201) {
      throw ServerException('Failed to create task: ${response.statusCode}');
    }

    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    return TaskModel.fromJson({
      'id': jsonData['id'] as int,
      'title': title,
      'description': description,
      'completed': false,
      'priority': priority ?? 'medium',
      'dueDate': dueDate,
    });
  }

  /// Updates an existing task on the server.
  /// Note: JSONPlaceholder API accepts PUT/PATCH but doesn't persist changes.
  Future<TaskModel> updateTask({
    required int id,
    String? title,
    String? description,
    bool? completed,
    String? priority,
    String? dueDate,
  }) async {
    final uri = Uri.parse('$_baseUrl/todos/$id');
    final body = {
      'id': id,
      'title': title,
      'completed': completed ?? false,
      'userId': 1,
      'priority': priority,
      'dueDate': dueDate,
    };
    // Remove null values
    body.removeWhere((key, value) => value == null && key != 'completed' && key != 'userId');

    final response = await client.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode != 200) {
      throw ServerException('Failed to update task: ${response.statusCode}');
    }

    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    return TaskModel.fromJson({
      'id': id,
      'title': title ?? jsonData['title'] as String,
      'description': description ?? '',
      'completed': completed ?? (jsonData['completed'] as bool),
      'priority': priority ?? 'medium',
      'dueDate': dueDate,
    });
  }

  /// Deletes a task on the server.
  /// Note: JSONPlaceholder API accepts DELETE but doesn't persist changes.
  Future<void> deleteTask(int taskId) async {
    final uri = Uri.parse('$_baseUrl/todos/$taskId');
    final response = await client.delete(uri);

    if (response.statusCode != 200) {
      throw ServerException('Failed to delete task: ${response.statusCode}');
    }
  }
}
