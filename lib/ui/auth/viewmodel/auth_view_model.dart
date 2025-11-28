import 'package:flutter/foundation.dart';

import '../../../data/repositories/auth/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  bool get isAuthenticated => _authRepository.isAuthenticated;

  Future<void> login({required String email, required String password}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _authRepository.login(email, password);
    } catch (error) {
      _error = 'Unable to sign in';
      debugPrint('$error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _authRepository.logout();
    notifyListeners();
  }
}
