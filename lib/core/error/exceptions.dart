
class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'Ошибка сервера']);

  @override
  String toString() => 'ServerException: $message';
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Ошибка кэша']);

  @override
  String toString() => 'CacheException: $message';
}
