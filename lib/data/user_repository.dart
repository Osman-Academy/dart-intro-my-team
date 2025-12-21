import 'package:dio/dio.dart';
import '../domain/user.dart';

class UserRepository {
  final Dio dio;

  UserRepository(this.dio);

  Future<List<User>> getUsers() async {
    try {
      final response = await dio.get('http://localhost:3000/users');
      final data = response.data as List;
      return data.map((json) => User.fromJson(json)).toList();
    } catch (e) {

      return _mockUsers();
    }
  }

  List<User> _mockUsers() {
    return const [
      User(name: 'Дастан', email: 'dastan@example.com'),
      User(name: 'Айбек', email: 'aibek@example.com'),
      User(name: 'Алия', email: 'aliya@example.com'),
      User(name: 'Нурбек', email: 'nurbek@example.com'),
      User(name: 'Жанна', email: 'zhanna@example.com'), User(name: 'Руслан', email: 'ruslan@example.com'),
      User(name: 'Камила', email: 'kamila@example.com'), User(name: 'Эмир', email: 'emir@example.com'),
      User(name: 'Азамат', email: 'azamat@example.com'), User(name: 'Саида', email: 'saida@example.com'),
      User(name: 'Бекзат', email: 'bekzat@example.com'),
      User(name: 'Мадина', email: 'madina@example.com'), User(name: 'Тимур', email: 'timur@example.com'),
      User(name: 'Асел', email: 'asel@example.com'), User(name: 'Жоомарт', email: 'zhoomart@example.com'),
      User(name: 'Айгуль', email: 'aigul@example.com'), User(name: 'Эльдар', email: 'eldar@example.com'),
      User(name: 'Гульмира', email: 'gulmira@example.com'), User(name: 'Мурат', email: 'murat@example.com'),
      User(name: 'Фарида', email: 'farida@example.com'), User(name:'Питер Паркер', email: 'spiderman@example.com' ),
    ];
  }
}
