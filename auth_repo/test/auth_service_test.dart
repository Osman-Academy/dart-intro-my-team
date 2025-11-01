import 'package:test/test.dart';
import 'package:auth_repo/auth_repo.dart';

void main() {
  group('AuthService', () {
    late AuthService s;

    setUp(() => s = AuthService());

    test('register and login', () {
      s.register('alice', 'pass');
      final u = s.login('alice', 'pass');
      expect(u.username, 'alice');
      expect(s.isAuthenticated, isTrue);
      s.logout();
      expect(s.isAuthenticated, isFalse);
    });

    test('invalid login throws', () {
      s.register('bob', 'secret');
      expect(() => s.login('bob', 'wrong'), throwsStateError);
    });

    test('duplicate register throws', () {
      s.register('carol', 'x');
      expect(() => s.register('carol', 'y'), throwsStateError);
    });
  });
}
