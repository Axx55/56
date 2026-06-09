import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/services/auth_service/auth_service_base.dart';

enum AuthStatus { uninitialized, authenticated, unauthenticated, loading }

class AuthProvider extends ChangeNotifier {
  final AuthServiceBase _authService;
  AuthStatus _status = AuthStatus.uninitialized;
  User? _user;
  String? _error;

  AuthProvider(this._authService) {
    _user = _authService.currentUser;
    _status = _user != null
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
  }

  AuthStatus get status => _status;
  User? get user => _user;
  String? get error => _error;
  bool get isLoggedIn => _status == AuthStatus.authenticated;

  Future<void> signIn(String identifier, String password) async {
    _status = AuthStatus.loading;
    _error = null;
    notifyListeners();
    try {
      final response = await _authService.signIn(identifier, password);
      _user = response.user;
      _status = AuthStatus.authenticated;
    } catch (e) {
      _error = e.toString();
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      await _authService.updatePassword(newPassword);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
