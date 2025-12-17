import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_finall_project/data/models/task_model.dart';

const String _tasksKey = 'cached_tasks';

/// Local data source that caches tasks using SharedPreferences.
/// Provides offline access to previously fetched tasks.
class TaskLocalDataSource {
  final SharedPreferences sharedPreferences;

  TaskLocalDataSource({required this.sharedPreferences});

  /// Saves a list of tasks to local cache.
  Future<void> cacheTasks(List<TaskModel> tasks) async {
    final jsonList = tasks.map((t) => t.toJson()).toList();
    await sharedPreferences.setString(_tasksKey, json.encode(jsonList));
  }

  /// Retrieves cached tasks from local storage.
  /// Returns an empty list if no cached tasks are found.
  Future<List<TaskModel>> getCachedTasks() async {
    final jsonString = sharedPreferences.getString(_tasksKey);
    if (jsonString == null) {
      return [];
    }

    try {
      final jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Clears all cached tasks.
  Future<void> clearCache() async {
    await sharedPreferences.remove(_tasksKey);
  }

  /// Checks if cached data exists.
  bool hasCachedTasks() {
    return sharedPreferences.containsKey(_tasksKey);
  }
}
