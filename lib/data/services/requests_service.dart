import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/add_child_request_model.dart';

class RequestsService {
  final SupabaseClient _client;

  RequestsService(this._client);

  Future<List<AddChildRequestModel>> getRequests({String? parentId}) async {
    dynamic query = _client.from('add_child_requests').select('*');
    if (parentId != null) query = query.eq('parent_id', parentId);
    query = query.order('created_at', ascending: false);
    final data = await query;
    return data.map((json) => AddChildRequestModel.fromJson(json)).toList();
  }

  Future<AddChildRequestModel> createRequest(Map<String, dynamic> data) async {
    final result = await _client
        .from('add_child_requests')
        .insert(data)
        .select()
        .single();
    return AddChildRequestModel.fromJson(result);
  }

  Future<void> deleteRequest(String id) async {
    await _client.from('add_child_requests').delete().eq('id', id);
  }
}
