import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthServiceBase {
  final SupabaseClient _supabase;

  AuthServiceBase(this._supabase);

  SupabaseClient get supabase => _supabase;

  Future<AuthResponse> signIn(String identifier, String password);
  Future<void> signOut();
  Session? get currentSession;
  User? get currentUser;
  bool get isLoggedIn;

  Future<void> sendPasswordResetEmail(String email);
  Future<void> updatePassword(String newPassword);
}
