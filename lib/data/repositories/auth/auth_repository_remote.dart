import 'auth_repository.dart';

class AuthRepositoryRemote extends AuthRepository {
  bool _isAuthenticated = false;

  @override
  bool get isAuthenticated => _isAuthenticated;

  @override
  Future<void> login(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _isAuthenticated = true;
    notifyListeners();
  }

  @override
  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
