import 'package:flutter/foundation.dart';

abstract class AuthRepository extends ChangeNotifier {
  bool get isAuthenticated;

  Future<void> login(String email, String password);

  void logout();
}
