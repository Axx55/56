import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/notification_model.dart';

class NotificationService {
  final SupabaseClient _client;

  NotificationService(this._client);

  Future<List<NotificationModel>> getNotifications({String? userId}) async {
    dynamic query = _client.from('notifications').select('*');
    if (userId != null) query = query.eq('user_id', userId);
    query = query.order('created_at', ascending: false);
    final data = await query as List<Map<String, dynamic>>;
    return data.map((json) => NotificationModel.fromJson(json)).toList();
  }

  Future<int> getUnreadCount(String userId) async {
    final response = await _client
        .from('notifications')
        .select('id')
        .eq('user_id', userId)
        .eq('is_read', false);
    return response.length;
  }

  Future<void> markAsRead(String notificationId) async {
    await _client
        .from('notifications')
        .update({'is_read': true})
        .eq('id', notificationId);
  }

  Future<void> markAllAsRead(String userId) async {
    await _client
        .from('notifications')
        .update({'is_read': true})
        .eq('user_id', userId)
        .eq('is_read', false);
  }
}
