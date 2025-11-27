import 'dart:async';

class AuthService {
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    if (username == 'admin' && password == '123') {
      return true;
    } else {
      return false;
    }
  }
}
