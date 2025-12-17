/// Custom exceptions for data layer errors.
class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server error']);

  @override
  String toString() => 'ServerException: $message';
}
