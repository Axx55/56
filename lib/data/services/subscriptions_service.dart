import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/subscription_model.dart';

class SubscriptionsService {
  final SupabaseClient _client;

  SubscriptionsService(this._client);

  Future<List<SubscriptionModel>> getSubscriptions({String? parentId}) async {
    var query = _client.from('subscriptions').select('*');
    if (parentId != null) {
      query = query.eq('parent_id', parentId);
    }
    final data = await query;
    return data.map((json) => SubscriptionModel.fromJson(json)).toList();
  }

  Future<SubscriptionModel?> getSubscriptionById(String id) async {
    final data = await _client
        .from('subscriptions')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    return data != null ? SubscriptionModel.fromJson(data) : null;
  }

  Future<SubscriptionModel> createSubscription(
    Map<String, dynamic> data,
  ) async {
    final result = await _client
        .from('subscriptions')
        .insert(data)
        .select()
        .single();
    return SubscriptionModel.fromJson(result);
  }

  Future<Map<String, int>> getSubscriptionStats(String parentId) async {
    final subscriptions = await getSubscriptions(parentId: parentId);
    return {
      'active': subscriptions.where((s) => s.status.name == 'active').length,
      'expired': subscriptions.where((s) => s.status.name == 'expired').length,
      'total': subscriptions.length,
    };
  }
}
