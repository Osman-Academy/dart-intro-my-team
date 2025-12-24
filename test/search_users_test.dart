import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:string_search_app/domain/entities/user.dart';
import 'package:string_search_app/domain/repositories/user_repository.dart';
import 'package:string_search_app/domain/usercases/search_users.dart';

// Generate mocks
@GenerateMocks([UserRepository])
import 'search_users_test.mocks.dart';

void main() {
  late SearchUsers searchUsers;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    searchUsers = SearchUsers(mockUserRepository);
  });

  group('SearchUsers', () {
    test('should return filtered users matching the pattern', () async {
      // Arrange
      const pattern = 'lea';
      final users = [
        const User(id: 1, name: 'Leanne Graham', email: 'leanne@example.com'),
        const User(id: 2, name: 'Ervin Howell', email: 'ervin@example.com'),
        const User(id: 3, name: 'Clementine Bauch', email: 'clementine@example.com'),
      ];
      when(mockUserRepository.getUsers()).thenAnswer((_) async => users);

      // Act
      final result = await searchUsers.call(pattern);

      // Assert
      expect(result.length, 1);
      expect(result.first.name, 'Leanne Graham');
      verify(mockUserRepository.getUsers()).called(1);
    });

    test('should return empty list when no matches', () async {
      // Arrange
      const pattern = 'xyz';
      final users = [
        const User(id: 1, name: 'Leanne Graham', email: 'leanne@example.com'),
      ];
      when(mockUserRepository.getUsers()).thenAnswer((_) async => users);

      // Act
      final result = await searchUsers.call(pattern);

      // Assert
      expect(result, isEmpty);
      verify(mockUserRepository.getUsers()).called(1);
    });

    test('should be case insensitive', () async {
      // Arrange
      const pattern = 'ERVIN';
      final users = [
        const User(id: 1, name: 'Leanne Graham', email: 'leanne@example.com'),
        const User(id: 2, name: 'Ervin Howell', email: 'ervin@example.com'),
      ];
      when(mockUserRepository.getUsers()).thenAnswer((_) async => users);

      // Act
      final result = await searchUsers.call(pattern);

      // Assert
      expect(result.length, 1);
      expect(result.first.name, 'Ervin Howell');
    });
  });
}