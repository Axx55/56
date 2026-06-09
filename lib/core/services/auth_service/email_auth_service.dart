import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_service_base.dart';

class EmailAuthService extends AuthServiceBase {
  EmailAuthService({required SupabaseClient supabase})
    : super(supabase: supabase);

  SupabaseClient get _client => supabase!;

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() => _client.auth.signOut();

  @override
  Session? get currentSession => _client.auth.currentSession;

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  bool get isLoggedIn => currentUser != null;

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await _client.auth.updateUser(UserAttributes(password: newPassword));
  }
}
