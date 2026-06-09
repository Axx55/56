import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth_service/auth_service_base.dart';

class MockAuthService extends AuthServiceBase {
  bool _isLoggedIn = false;

  static const String testPhone = '0501234567';
  static const String testPassword = '123456';

  MockAuthService() : super();

  @override
  Future<AuthResponse> signIn(String phone, String password) async {
    if (phone != testPhone || password != testPassword) {
      throw Exception('رقم الهاتف أو كلمة المرور غير صحيحة');
    }
    _isLoggedIn = true;
    return AuthResponse(
      session: Session.fromJson({
        'access_token': 'mock-token',
        'token_type': 'bearer',
        'user': {'id': 'mock-user-1', 'phone': phone},
      }),
      user: User.fromJson({
        'id': 'mock-user-1',
        'phone': phone,
        'role': 'authenticated',
      }),
    );
  }

  @override
  Future<void> signOut() async {
    _isLoggedIn = false;
  }

  @override
  Session? get currentSession => null;

  @override
  User? get currentUser => _isLoggedIn
      ? User.fromJson({
          'id': 'mock-user-1',
          'phone': testPhone,
          'role': 'authenticated',
        })
      : null;

  @override
  bool get isLoggedIn => _isLoggedIn;

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<void> updatePassword(String newPassword) async {}
}
