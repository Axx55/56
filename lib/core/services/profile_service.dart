import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final SupabaseClient _supabase;

  ProfileService(this._supabase);

  Future<Map<String, dynamic>?> getProfile(String userId) async {
    final response = await _supabase
        .from('parents')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    return response;
  }

  Future<void> updateProfile(String userId, Map<String, dynamic> data) async {
    await _supabase.from('parents').update(data).eq('user_id', userId);
  }

  Future<Map<String, dynamic>?> getUserType(String userId) async {
    final response = await _supabase
        .from('profiles')
        .select('user_type')
        .eq('id', userId)
        .maybeSingle();
    return response;
  }
}
