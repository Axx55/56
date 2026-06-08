import 'package:supabase_flutter/supabase_flutter.dart';

class StatisticsService {
  final SupabaseClient _client;

  StatisticsService(this._client);

  Future<int> getStudentsCount(String parentId) async {
    final data = await _client
        .from('students')
        .select('id')
        .eq('parent_id', parentId);
    return data.length;
  }

  Future<int> getActiveSubscriptionsCount(String parentId) async {
    final data = await _client
        .from('subscriptions')
        .select('id')
        .eq('parent_id', parentId)
        .eq('status', 'active');
    return data.length;
  }

  Future<Map<String, dynamic>> getDashboardStats(String parentId) async {
    final studentsCount = await getStudentsCount(parentId);
    final activeSubs = await getActiveSubscriptionsCount(parentId);
    return {
      'students_count': studentsCount,
      'active_subscriptions': activeSubs,
    };
  }
}
