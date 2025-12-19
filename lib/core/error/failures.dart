import 'package:equatable/equatable.dart';

// Базовый класс для всех ошибок
abstract class Failure extends Equatable {
  final String message;
  
  const Failure(this.message);
  
  @override
  List<Object> get props => [message];
}

// Ошибка сервера
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

// Нет интернета
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

// Ошибка кеша/локального хранилища
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

// Общая ошибка
class GeneralFailure extends Failure {
  const GeneralFailure([super.message = 'Something went wrong']);
}