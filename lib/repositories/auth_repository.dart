
abstract class AuthRepository {
  
  Future<String> login(String username, String password);

 
  Future<void> logout();

 
  Future<bool> isLoggedIn();

  Future<String?> getCurrentUserId();
}
