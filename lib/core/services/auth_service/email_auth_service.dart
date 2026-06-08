import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_service_base.dart';

class EmailAuthService extends AuthServiceBase {
  EmailAuthService(super.supabase);

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    return supabase.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() => supabase.auth.signOut();

  @override
  Session? get currentSession => supabase.auth.currentSession;

  @override
  User? get currentUser => supabase.auth.currentUser;

  @override
  bool get isLoggedIn => currentUser != null;

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }
}
