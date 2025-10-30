import 'dart:io';

class AuthRepository {
  String? _token;

  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (username == "nura" && password == "23112004") {
      _token = "realtoken123";
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    if (!isLoggedIn)  print("You are not even logged in!");
    else{
      await Future.delayed(const Duration(milliseconds: 500));
    _token = null;
     print("Logged out!!!!YAYAYAYY");
  }}

  bool get isLoggedIn => _token != null;
}

void main() async {
  var auth = AuthRepository();

  while(true){
    print("1. I want to login 2. I need to logout");
    var input = stdin.readLineSync();
  
    if(input=="1"){
      print("Username:");
      var username = stdin.readLineSync() ?? "";
      print("Password:");
      var password = stdin.readLineSync() ?? "";
      bool success = await auth.login(username, password);


      if(success){
        print("Login successful!");
      } else {
        print("Login failed(((");
      }


    } else if(input=="2"){
      await auth.logout();
    


  }}
}
