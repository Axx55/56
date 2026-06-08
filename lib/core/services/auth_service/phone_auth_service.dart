import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_service_base.dart';

class PhoneAuthService extends AuthServiceBase {
  PhoneAuthService(super.supabase);

  @override
  Future<AuthResponse> signIn(String phone, String password) async {
    return supabase.auth.signInWithPassword(phone: phone, password: password);
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
    throw UnimplementedError('Use email for password reset');
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }
}
