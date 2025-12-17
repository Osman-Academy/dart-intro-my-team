/// Enumeration for task priority levels.
enum TaskPriority {
  low,
  medium,
  high,
}

extension TaskPriorityX on TaskPriority {
  /// Get display name for the priority.
  String get displayName {
    switch (this) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
    }
  }

  /// Get color representation for UI.
  /// Returns a color code as string for easy theming.
  String get colorCode {
    switch (this) {
      case TaskPriority.low:
        return '#4CAF50'; // Green
      case TaskPriority.medium:
        return '#FF9800'; // Orange
      case TaskPriority.high:
        return '#F44336'; // Red
    }
  }

  /// Convert string to TaskPriority enum.
  static TaskPriority fromString(String value) {
    return TaskPriority.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => TaskPriority.medium,
    );
  }

  /// Convert enum to string.
  String toStringValue() => name;
}
