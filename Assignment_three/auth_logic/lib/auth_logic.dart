import 'account_repo.dart';

class UserData {
  String? email;

  UserData({this.email});

  final AccountRepo _accountRepo = AccountRepo();

  bool login(String password) {
    return _accountRepo.authenticate(email!, password);
  }

  void logout() {
    email = null;
  }
}
