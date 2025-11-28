import 'auth_repository.dart';

class AuthRepositoryDev extends AuthRepository {
  bool _isAuthenticated = true;

  @override
  bool get isAuthenticated => _isAuthenticated;

  @override
  Future<void> login(String email, String password) async {
    _isAuthenticated = true;
    notifyListeners();
  }

  @override
  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
